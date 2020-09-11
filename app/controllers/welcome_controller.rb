class WelcomeController < ApplicationController
  before_action :authenticate_user!

  require 'rqrcode'

  def index
  end
end
