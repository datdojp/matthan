class AuthenticatedController < ApplicationController

  before_action :check_login

end