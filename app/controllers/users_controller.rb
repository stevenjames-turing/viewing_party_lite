# frozen_string_literal: true

class UsersController < ApplicationController
  def new; end

  def show
    @user = User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if (user.save) && (valid_pass == true)
      redirect_to "/users/#{user.id}"
    else
      redirect_to '/register'
      flash.notice = user.errors.full_messages.to_sentence
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
