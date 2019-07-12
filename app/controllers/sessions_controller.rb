# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :set_user, only: %i[create]

  def new
  end

  def create
    if @user&.authenticate(params[:login][:password])
      session[:user_id] = @user.id.to_s
      flash[:success] = 'Admin was authenticated.'
      redirect_to root_path
    else
      flash[:warning] = 'Wrong credentials'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
  end

  private

  def set_user
    @user = User.find_by(email: params[:login][:email].downcase)
  end
end
