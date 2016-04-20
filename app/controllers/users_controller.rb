class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.except(:password_confirm))
    if @user.save
      flash[:success] = "User account successfully created!"
      login(@user)
      redirect_to "/products"
    elsif user_params[:password] != user_params[:password_confirm]
      flash.now[:danger] = "Your passwords did not match"
      render :new
    else
      flash.now[:danger] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirm)
  end
end
