class InterviewsController < ApplicationController

  def index
    @interview_days = InterviewDay.all.includes(:interviews, :applicants)
  end


  def update
    @interview = Interview.find(params[:id])

    if params[:register] && @interview.free? && applicant?
      @interview.applicant = applicant?
      @interview.reserved!
    end

    if params[:deregister]
      if @interview.applicant = applicant?
        @interview.free!
        @interview.applicant = nil
        applicant?.interview = nil
      end
    end

    if params[:status_change] && admin?
      if params[:status_change] == "disable"
        @interview.disabled!
      elsif params[:status_change] == "enable"
        @interview.free!
      end
    end


    respond_to do |format|
      format.html do
        redirect_to interviews_path
      end
      format.js do
        render :partial => 'interviews/interview_details', :locals => { :interview => @interview }
      end
    end
  end
end

