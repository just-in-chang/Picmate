# frozen_string_literal: true

# Controller for sign up and login
class UsersController < ApplicationController
  def sign_up
    user = User.find_by(username: user_params[:username])

    if user.present?
      render json: { status: 'error', message: 'Username already taken' }
    else
      user = User.new(user_params)
      render json: { status: user.save ? 'success' : 'error' }
    end
  end

  def login
    user = User.find_by(username: user_params[:username])

    if user.present? && user.password == params[:password]
      render json: { status: 'success' }
    else
      render json: { status: 'error', message: 'Incorrect username or password' }
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
