# frozen_string_literal: true

class UsersController < ApplicationController
  def new; end

  def show
    @user = User.find(session[:user_id]) if session[:user_id]
  end

  def create
    user = User.new(user_params)
    if (user.save) && (valid_pass == true)
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      redirect_to '/register'
      flash.notice = user.errors.full_messages.to_sentence
    end
  end
  
  def login_form; end
  
  def login_user
    user = User.find_by(email: params[:email])
    if !user.nil? && user.authenticate(params[:password]) != false 
      session[:user_id] = user.id
      redirect_to dashboard_path
    else 
      redirect_to login_form_path
      flash.notice = "Invalid Credentials"
    end
  end

  private 

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def valid_pass
    true if params[:password] == params[:password_confirmation]
  end
end
