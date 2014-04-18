class ApplicantsController < ApplicationController
  before_action :set_applicant, only: [:show, :edit, :update, :destroy]
  skip_before_action :auth!, only: [:show]

  # GET /applicants
  # GET /applicants.json
  def index
    respond_access_denied unless admin?
    @show_missing_points = params[:show_missing_points]
    @show_weekly_points = params[:show_points]
    direction = if params[:direction] == "asc"
                  :asc
                else
                  :desc
                end

    interesting_orders = %w(message_sent essay name nick email missing_points week1 week2 week3 week4 wek5 week6 week7 week8 week9 week10 week11 week12)
    fields = interesting_orders.map {|o| params[o.to_sym]? o.to_sym : nil}.compact
    if fields.empty?
      fields << :name
      params[:name] = 1
    end

    condition = if params[:ready_for_exam]
      'week1 >= 85 and week2 >= 85 and week3 >= 85 and week4 >= 85 and week5 >= 85 and week6 >= 85 and week7 >= 85 and week8 >= 85 and week9 >= 85 and week10 >= 85 and week11 >= 85 and week12 >= 85 and missing_points == ""'
    end

    @applicants = if fields.any?
                    if condition
                      Applicant.where(condition).order(fields.map{|f| [f => direction]})
                    else
                      Applicant.order(fields.map{|f| [f => direction]})
                    end
                  else
                    Applicant.all
                  end
  end

  # GET /applicants/1
  # GET /applicants/1.json
  def show
    session[:applicant_token] = params[:id] unless current_user
  end

  # GET /applicants/1/edit
  def edit
  end

  # PATCH/PUT /applicants/1
  # PATCH/PUT /applicants/1.json
  def update
    respond_to do |format|
      if @applicant.update(applicant_params)
        format.html { redirect_to @applicant, notice: 'Applicant was successfully updated.' }
        format.json { render :show, status: :ok, location: @applicant }
      else
        format.html { render :edit }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_applicant
    @applicant = Applicant.where(key: params[:id]).first
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def applicant_params
    if admin?
      params.require(:applicant).permit(:name, :email, :essay, :message_sent)
    else
      params.require(:applicant).permit(:essay)
    end
  end
end
