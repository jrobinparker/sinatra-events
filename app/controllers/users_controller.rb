class UsersController < ApplicationController

  get '/' do
    @user = User.find_by_id(params[:id])
    erb :'users/index'
  end

end
