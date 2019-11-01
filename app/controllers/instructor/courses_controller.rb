class Instructor::CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_user, only: [:show]

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.create(course_params)
    if @course.valid?
      redirect_to instructor_course_path(@course)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :cost)
  end

  helper_method :current_course
  def current_course
    @current_course ||= Course.find(params[:id])
  end

  def render_eperm
    render plain: "Unauthorized", status: :Unauthorized
  end

  def require_authorized_user
    render_eperm unless current_course.user == current_user
  end
end
