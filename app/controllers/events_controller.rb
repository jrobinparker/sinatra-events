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
    @event = Event.new(name: params[:name], start_date: params[:start_date], start_time: params[:start_time], end_date: params[:end_date], end_time: params[:end_time], description: params[:description])
    @event.user_id = current_user.id
    if @event.save
      redirect to "/#{@event.id}"
    else
      erb :"events/new"
    end
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
      if @event.user_id == current_user.id
        erb :"events/edit"
      else
        redirect to "/#{@event.id}"
      end
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
    if @event.save
      redirect to "/#{@event.id}"
    else
      @event = Event.find_by_id(params[:id])
      erb :"events/edit"
    end
  end

  delete '/:id/delete' do
    if logged_in?
      @event = Event.find_by_id(params[:id])
      if @event.user_id == current_user.id
        @event.delete
        redirect "events"
      else
        redirect to "/#{@event.id}"
      end
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
