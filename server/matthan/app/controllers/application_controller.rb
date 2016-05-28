class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout 'application'

  def authenticated?
    !session[:owner].nil?
  end

  private

  def check_login
    unless session[:owner]
      show_error('Bạn chưa đăng nhập')
      redirect_to login_path
      return false
    end
    return true
  end

  def show_error(msg)
    flash[:error] = msg
  end

  def show_info(msg)
    flash[:info] = msg
  end
end
