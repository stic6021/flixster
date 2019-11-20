class User < ApplicationRecord
  has_many :courses
  has_many :enrollments
  has_many :enrolled_courses, through: :enrollments, source: :course
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def enrolled_in?(course)
    # Enrollment.find_by_course_id_and_user_id(course.id, self.id).valid? rescue false
    enrolled_courses.include?(course)
  end

  private

  def all_enrolled
    Enrollment.where(user_id: self.id)
  end
end
