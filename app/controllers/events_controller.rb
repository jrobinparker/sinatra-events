class EventsController < ApplicationController

  get '/' do
    @events = Event.all
    erb :"events/index"
  end

  get '/new' do
    erb :"events/new"
  end

  post '/' do
    @event = Event.create(params[:event])
    @event.save
    redirect to "events/#{@event.id}"
  end

  get '/:id' do
    @event = Event.find_by_id(params[:id])
    erb :"events/show"
  end

  get '/:id/edit' do
    @event = Event.find_by_id(params[:id])
    erb :"events/edit"
  end

  post '/:id' do
    @event = Event.find_by_id(params[:id])
    @event = Event.update(params[:event])
    @event.save
    redirect to "events/#{@event.id}"
  end

  delete '/:id/delete' do
    @event = Event.find_by_id(params[:id])
    @event.delete
    redirect to "events"
  end 

end
