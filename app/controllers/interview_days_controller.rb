class InterviewDaysController < ApplicationController

  def index
    @interview_day = InterviewDay.all
  end

  def show
    @interview_day = InterviewDay.find(params[:id])
  end

  def update
    @interview = Interview.find(params[:id])
    @applicant = Applicant.find(params[:applicant_id])
    Applicant.transaction do
      Interview.transaction do
        InterviewDay.transaction do
          if admin?
            if params[:mark_as_arrived]
              @applicant.arrived = true
            elsif params[:mark_as_not_arrived]
              @applicant.arrived = false
            end
            if params[:applicant][:arrival_time]
              begin
                time = params[:applicant][:arrival_time]
                @applicant.arrival_time = DateTime.parse(time)
              rescue
              end
            end
            @applicant.save! if @applicant
            @interview.save! if @interview
          end
        end
      end
      respond_to do |format|
        format.html do
          redirect_to @interview_day
        end
        format.js do
          render :partial => 'interview_days/applicant_details', :locals => { :applicant => @applicant, interview: @interview }
        end
      end
    end
  end
end
