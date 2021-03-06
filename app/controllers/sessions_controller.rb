class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      flash[:success] = "Successfully logged in!"
      login(user)
      redirect_to '/products'
    else
      flash.now[:danger] = 'Email or password was incorrect'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged out successfully"
    redirect_to "/products"
  end
end
