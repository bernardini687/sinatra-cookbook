require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

get '/' do # <- Router part
  @usernames = %w[Papillard ssaunier bernardini687 mhartl] # <- Controller part
  erb :index # <- View is in views/index.erb
end

get '/about' do
  erb :about
end

get '/team/:username' do
  "The username is #{params[:username]}"
end
