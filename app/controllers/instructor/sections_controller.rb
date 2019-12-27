class Instructor::SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_user, only: [:new, :create]
  before_action :require_authorized_for_current_section, only: [:update]
  skip_before_action :verify_authenticity_token, only: [:update]

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

  def update
    current_section.update_attributes(section_params)
    render plain: 'updated'
  end

  private

  def section_params
    params.require(:section).permit(:title, :row_order_position)
  end

  helper_method :current_course
  def current_course
    if course_id
      @current_course ||= Course.find(params[:course_id])
    else
      current_section.course
    end
  end

  helper_method :current_section
  def current_section
    @current_section ||= Section.find(params[:id])
  end

  def render_eperm
    render plain: "Unauthorized", status: :Unauthorized
  end

  def require_authorized_user
    render_eperm unless current_course.user == current_user
  end

  def require_authorized_for_current_section
    render plain: 'Not authorized', status: :unauthorized unless current_section.course.user == current_user
  end
end
