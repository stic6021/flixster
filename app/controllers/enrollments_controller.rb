class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  def create
    enrollment = current_user.enrollments.create(course: current_course)
    if enrollment.valid?
      redirect_to course_path(current_course)
    end
  end

  private

  def current_course
    @current_course ||= Course.find(params[:course_id])
  end
end
