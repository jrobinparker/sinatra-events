require './config/environment'
require 'sinatra'

require './app/controllers/events_controller'
require './app/controllers/application_controller'

use Rack::MethodOverride

map('/events') { run EventsController }
map('/') { run ApplicationController }
