class Instructor::LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_user, only: [:create]
  before_action :require_authorized_for_current_lesson, only: [:update]
  skip_before_action :verify_authenticity_token, only: [:update]

  def create
    @lesson = current_section.lessons.create(lesson_params)
    if @lesson.valid?
      redirect_to instructor_course_path(current_section.course)
    else
      render :new, :unprocessable_entity
    end
  end

  def update
    current_lesson.update_attributes(lesson_params)
    render plain: 'updated'
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  helper_method :current_section
  def current_section
    @current_section ||= Section.find(params[:section_id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :subtitle, :video, :row_order_position)
  end

  def render_eperm
    render plain: "Unauthorized", status: :Unauthorized
  end

  def require_authorized_user
    render_eperm unless current_section.course.user == current_user
  end

  def require_authorized_for_current_lesson
    if current_lesson.section.course.user != current_user
      render plain: 'Not authorized', status: :unauthorized
    end
  end
end
