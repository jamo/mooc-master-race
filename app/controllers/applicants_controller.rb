class ApplicantsController < ApplicationController
  before_action :set_applicant, only: [:show, :edit, :update, :destroy]
  skip_before_action :auth!, only: [:show]

  # GET /applicants
  # GET /applicants.json
  def index
    respond_access_denied unless admin?
    order = case params[:sort_by]
            when 'name'
              'name'
            when 'nick'
              'nick'
            when 'email'
              'email'
            when 'missing_points'
              'missing_points'
            when /week\d+/
              "#{params[:sort_by]}"
            end

    direction = if params[:direction] == "asc"
                  "ASC"
                elsif params[:direction] == "desc"
                  "DESC"
                end

    @applicants = if order
                    Applicant.order("#{order} #{direction}")
                  else
                    Applicant.all
                  end
  end

  # GET /applicants/1
  # GET /applicants/1.json
  def show
    session[:applicant_token] = params[:id]
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
    params.require(:applicant).permit(:essay)
  end
end
