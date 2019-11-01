class Instructor::SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_user

  def create
    @section = current_course.sections.create(section_params)
    if @section.valid?
      redirect_to instructor_course_path(current_course)
    else
      render :new, :unprocessable_entity
    end
  end

  def new
    @section = Section.new
  end

  private

  def section_params
    params.require(:section).permit(:title)
  end

  helper_method :current_course
  def current_course
    @current_course ||= Course.find(params[:course_id])
  end

  def render_eperm
    render plain: "Unauthorized", status: :Unauthorized
  end

  def require_authorized_user
    render_eperm unless current_course.user == current_user
  end
end
