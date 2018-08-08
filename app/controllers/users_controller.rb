class UsersController < ApplicationController

  get '/' do
  erb :'users/login'
end

get "/signup" do
  if logged_in?
    redirect to "events"
  else
    erb :'users/signup'
  end
end

post "/signup" do
 if params[:username] == "" || params[:email] == "" || params[:password] == "" || params[:first_name] == "" || params[:last_name] == ""
   redirect 'home/signup'
 else
   @user = User.create(username: params[:username], password: params[:password], email: params[:email], first_name: params[:first_name], last_name: params[:last_name])
   if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect to "events"
  end
 end
end

get "/login" do
  if logged_in?
    redirect to "events"
  else
    erb :'users/login'
  end
end

post "/login" do
  @user = User.find_by(username: params[:username])
  if @user && @user.authenticate(params[:password])
   session[:user_id] = @user.id
   redirect to "events"
  else
   redirect to "users/failure"
  end
end

get "/failure" do
 erb :'home/failure'
end

get "/logout" do
 session.clear
 redirect "users/login"
end

end
