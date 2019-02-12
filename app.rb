require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'
require_relative 'cookbook'
require_relative 'recipe'
set :bind, '0.0.0.0'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

get '/' do # <- Router part
  @recipes = Cookbook.new('recipes.csv').all # <- Controller part
  erb :index # <- View is in views/index.erb
end

post '/create' do
  cookbook = Cookbook.new('recipes.csv')
  recipe = Recipe.new(params[:name].capitalize, params[:description].capitalize)
  cookbook.add(recipe)
  redirect to '/'
end

get '/new' do
  erb :new
end

get '/team/:username' do
  "The username is #{params[:username]}" # <- params is {"username"=>"testing"}
end
