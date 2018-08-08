require './config/environment'
require 'sinatra'

require_relative 'app/controllers/events_controller'
require_relative 'app/controllers/users_controller'
require_relative 'app/controllers/application_controller'

use Rack::MethodOverride

map('/events') { run EventsController }
map('/users') { run UsersController }
map('/') { run ApplicationController }
