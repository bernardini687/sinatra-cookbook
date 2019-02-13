require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

require_relative 'cookbook'
require_relative 'recipe'

get '/' do # <- Router part
  @recipes = Cookbook.new('recipes.csv').all # <- Controller part
  erb :index # <- View is in views/index.erb
end

get '/new' do
  erb :new
end

post '/recipes' do
  cookbook = Cookbook.new('recipes.csv')
  recipe = Recipe.new(
    params[:name].capitalize,
    params[:blurb].capitalize,
    params[:gravity],
    params[:preptime]
  )
  cookbook.add(recipe)
  redirect to '/'
end

get '/recipes/:index' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv')) # <- Understand...
  cookbook.remove(params[:index].to_i)
  redirect to '/'
end
