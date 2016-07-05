class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home
    @contact = Contact.new
    @days_together = (Date.today - Date.parse('02/07/2014')).numerator
    @days_since_we_met = (Date.today - Date.parse('03/07/2013')).numerator
  end

  def information
    @registries = Registry.all
  end
end
