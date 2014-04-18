class AdminController < ApplicationController
  def index
    return access_denied unless admin?

    Settings.email_template = params[:email_template] if params[:email_template]
    Settings.questionary_notes = params[:questionary_notes] if params[:questionary_notes]
  end
end
