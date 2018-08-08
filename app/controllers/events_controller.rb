class EventsController < ApplicationController

  get '/' do
    @events = Event.all
    erb :"events/index"
  end

  get '/new' do
    erb :"events/new"
  end

  post '/' do
    @event = Event.create(name: params[:name], start_date: params[:start_date], start_time: params[:start_time], end_date: params[:end_date], end_time: params[:end_time], description: params[:description])
    @event.save
    redirect to "/#{@event.id}"
  end

  get '/:id' do
    @event = Event.find_by_id(params[:id])
    erb :"events/show"
  end

  get '/:id/edit' do
    @event = Event.find_by_id(params[:id])
    erb :"events/edit"
  end

  patch '/:id' do
    @event = Event.find_by_id(params[:id])
    @event.name = params[:name]
    @event.start_date = params[:start_date]
    @event.start_time = params[:start_time]
    @event.end_date = params[:end_date]
    @event.end_time = params[:end_time]
    @event.description = params[:description]
    @event.save
    redirect "events/#{@event.id}"
  end

  delete '/:id/delete' do
    @event = Event.find_by_id(params[:id])
    @event.delete
    redirect "events"
  end

end
