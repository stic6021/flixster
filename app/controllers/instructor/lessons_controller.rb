class Instructor::LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_user

  def create
    @lesson = current_section.lessons.create(lesson_params)
    if @lesson.valid?
      redirect_to instructor_course_path(current_section.course)
    else
      render :new, :unprocessable_entity
    end
  end

  def new
    @lesson = Lesson.new
  end

  private

  helper_method :current_section
  def current_section
    @current_section ||= Section.find(params[:section_id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :subtitle)
  end

  def render_eperm
    render plain: "Unauthorized", status: :Unauthorized
  end

  def require_authorized_user
    return render_eperm unless current_section.course.user == current_user
  end
end
