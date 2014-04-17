class InterviewsController < ApplicationController


  def index
    @interview_days = InterviewDay.all
  end


  def update
    interview = Interview.find(params[:id])

    unless interview.free?
      #virhe
      raise
    end

    interview.reserved!

    redirect_to interviews_path
  end

end
