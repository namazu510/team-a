class LoginsController < ApplicationController
  def index
    render "index"
  end

  def show
    render "new"
  end

  def create
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password]
      session[:user_id]  user.id
      redirect_to root_path
    else
      flash.now.alert = "もう一度入力してください"
      render "new"
    end

  def destroy
    session[:user_id] = nil
    @current_user = nil
    redirect_to root_path
  end
end
