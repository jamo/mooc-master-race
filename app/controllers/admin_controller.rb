class AdminController < ApplicationController
  def index
    return respond_access_denied unless admin?

    if params[:refresh_from_tmc]
      Applicant.update_all_data_with_tmc
      redirect_to admin_index_path, notice: "Updated data"
    end
    Settings.email_title = params[:email_title] if params[:email_title]
    Settings.email_template = params[:email_template] if params[:email_template]
    Settings.questionary_notes = params[:questionary_notes] if params[:questionary_notes]
  end
end
