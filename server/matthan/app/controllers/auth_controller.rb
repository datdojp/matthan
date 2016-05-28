require 'digest/md5'

class AuthController < ApplicationController

  def login
    @title = 'Đăng nhập'
  end

  def submit
    @email = params['email']
    @password = params['password']

    hashed_password = Digest::MD5.hexdigest(@password)
    owner = Owner.where(email: @email, password: hashed_password).first
    unless owner
      show_error('Email hoặc Password không chính xác')
      render 'login'
      return
    end

    session[:owner] = {
      id: owner.id.to_s,
      role: owner.role
    }
    redirect_to operations_path
  end

  def logout
    session[:owner] = nil
    redirect_to login_path
  end

end