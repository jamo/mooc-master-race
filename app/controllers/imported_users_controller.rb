class ImportedUsersController < ApplicationController

  def index
    return respond_access_denied unless admin?
    return respond_access_denied if apprentice?

    # Default options
    unless params[:filtering]
      params[:only_mooc] = 1
      params[:applicant_id] = 1
      params[:last_name] = 1
    end

    direction = if params[:direction] == "desc"
                  :desc
                else
                  :asc
                end

    interesting_orders = %i(applicant_id last_name preferred_name email phone mooc eligible key created_at)
    fields = interesting_orders.map {|o| params[o]? o : nil}.compact
    if fields.empty?
      fields << :last_name
      params[:last_name] = 1
    end

    @imported_users = ImportedUser.order(fields.map{|f| [f => direction]}).includes(:applicant)

    if params[:only_mooc]
      @imported_users = @imported_users.where(mooc: true)
    end
  end
end
