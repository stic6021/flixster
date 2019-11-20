class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_user

  def show
  end

  private

  helper_method :current_course
  def current_course
    @current_course ||= current_lesson.section.course rescue nil
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def require_authorized_user
    redirect_to(course_path(current_course), alert: "You must enroll in this course to view its lesson details.") unless current_user.enrolled_in?(current_course)
  end
end
