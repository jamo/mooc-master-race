class InterviewDaysController < ApplicationController

  def index
    @interview_day = InterviewDay.all
  end

  def show
    @interview_day = InterviewDay.find(params[:id])
  end
end
