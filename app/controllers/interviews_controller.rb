# encoding: UTF-8
class InterviewsController < ApplicationController

  def index
    @interview_days = InterviewDay.all.includes(:interviews, :applicants)
  end


  def update

    Applicant.transaction do
      Interview.transaction do
        @interview = Interview.find(params[:id])
        applicant = applicant?
        if params[:register] && applicant

          if @interview.free? and applicant.interview.nil?
            @interview.applicant = applicant?
            applicant.interview = @interview
            @interview.reserved!
            flash[:notice] = "Aika varattu"
          else
            flash[:error] = "Ajanvaraus epäonnistui - päivitä sivu ja varaa aika uudestaan!"
          end
        elsif params[:deregister]
          if @interview.applicant == applicant and applicant.interview
            @interview.free!
            @interview.applicant = nil
            applicant.interview = nil
            flash[:notice] = "Aijanvaraus peruttu"
          end
        elsif params[:status_change] && admin?
          if params[:status_change] == "disable"
            @interview.disabled!
          elsif params[:status_change] == "enable"
            @interview.free!
          end
        end
        applicant.save! if applicant
        @interview.save! if @interview
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

