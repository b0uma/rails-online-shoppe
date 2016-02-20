class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      flash[:success] = "Successfully logged in!"
      session[:user_id] = user.id
      redirect_to '/products'
    else
      flash.now[:errors] = 'Email or password was incorrect'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/products"
  end
end
