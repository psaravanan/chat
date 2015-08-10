class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
  	# UserMailer.test_email.deliver
  end
end
