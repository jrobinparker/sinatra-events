class EventsController < ApplicationController

  get '/' do
    if logged_in?
      @events = Event.all
      erb :"events/index"
    else
      redirect "/login"
    end
  end

  get '/new' do
    if logged_in?
      erb :"events/new"
    else
      redirect "/login"
    end
  end

  post '/' do
    @event = Event.create(name: params[:name], start_date: params[:start_date], start_time: params[:start_time], end_date: params[:end_date], end_time: params[:end_time], description: params[:description])
    @event.save
    redirect to "/#{@event.id}"
  end

  get '/:id' do
    if logged_in?
      @event = Event.find_by_id(params[:id])
      erb :"events/show"
    else
      redirect "/login"
    end
  end

  get '/:id/edit' do
    if logged_in?
      @event = Event.find_by_id(params[:id])
      erb :"events/edit"
    else
      redirect "/login"
    end
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
    if logged_in?
      @event = Event.find_by_id(params[:id])
      @event.delete
      redirect "events"
    else
      redirect "/login"
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @user = User.find(session[:user_id])
    end
  end

end
