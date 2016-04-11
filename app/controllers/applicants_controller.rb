# encoding: UTF-8
class ApplicantsController < ApplicationController
  before_action :set_applicant, only: [:show, :edit, :update, :destroy, :send_email]
  skip_before_action :auth!, only: [:show]

  # GET /applicants
  # GET /applicants.json
  def index
    return respond_access_denied unless admin?
    return respond_access_denied if apprentice?
    @show_missing_points = params[:show_missing_points]
    @show_weekly_points = params[:show_points]
    @show_explanations = params[:show_explanations]
    direction = if params[:direction] == "asc"
                  :asc
                else
                  :desc
                end

    interesting_orders = %w(message_sent essay ready_for_interview interview_id name nick email missing_points week1 week2 week3 week4 wek5 week6 week7 week8 week9 week10 week11 week12 week13 week14 explanations)
    fields = interesting_orders.map {|o| params[o.to_sym]? o.to_sym : nil}.compact
    if fields.empty?
      fields << :name
      params[:name] = 1
    end

    condition = if params[:ready_for_exam] or params[:not_ready_for_exam]
                  'week1 >= 90 and week2 >= 90 and week3 >= 90 and week4 >= 90 and week5 >= 90 and week6 >= 90 and week7 >= 90 and week8 >= 90 and week9 >= 90 and week10 >= 90 and week11 >= 90 and week12 >= 90and week13 >= 90 and week14 >= 90'
                elsif params[:filter_failed] && params[:failed_to]
                  week = params[:failed_to].to_i
                  1.upto(week).map {|i| "week#{i} < 90"}.join(" or ")
                elsif params[:filter_not_failed] && params[:failed_to]
                  week = params[:failed_to].to_i
                  1.upto(week).map {|i| "week#{i} >= 90"}.join(" and ")
                end

    @applicants = if fields.any?
                    if params[:ready_for_exam] || (params[:filter_failed] && params[:failed_to])
                      Applicant.where(condition).includes(:imported_user).order(fields.map{|f| [f => direction]})
                    elsif (params[:filter_not_failed] && params[:failed_to])
                      Applicant.where(condition).includes(:imported_user, :interview).order(fields.map{|f| [f => direction]})
                    elsif params[:not_ready_for_exam]
                      Applicant.where.not(condition).includes(:imported_user, :interview).order(fields.map{|f| [f => direction]})
                    else
                      Applicant.includes(:imported_user, :interview).order(fields.map{|f| [f => direction]})
                    end
                  else
                    Applicant.all.includes(:imported_user, :interview)
                  end
  end

  # GET /applicants/1
  # GET /applicants/1.json
  def show
    return respond_access_denied if apprentice?
    # logs in the applicant :D
    session[:applicant_token] = params[:id] unless current_user
    @title = Settings.email_title
    @email = ERB.new(Settings.email_template).result(get_binding)
  end

  def send_email
    return respond_access_denied if apprentice?
    session[:applicant_token] = params[:id] unless current_user
    @email = ERB.new(Settings.email_template).result(get_binding)
    @title = Settings.email_title
    SignUpMailer.sign_up(@applicant.email, @title, @email).deliver!
    @applicant.update_attributes(message_sent: true)
    redirect_to applicant_path(@applicant.key), notice: 'Email sent'
  end

  def get_binding
    binding
  end

  def edit
    return respond_access_denied if apprentice?
  end

  def update
    return respond_access_denied if @applicant.arrived?
    respond_to do |format|
      if @applicant.update(applicant_params)
        format.html { redirect_to @applicant, notice: 'Kirjoitelma päivitetty.' }
        format.json { render :show, status: :ok, location: @applicant }
      else
        format.html { render :edit }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def set_applicant
    @applicant = Applicant.where(key: params[:id]).first
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def applicant_params
    if admin?
      params.require(:applicant).permit(:name, :email, :essay, :message_sent, :phone_number)
    else
      params.require(:applicant).permit(:essay, :phone_number)
    end
  end
end
