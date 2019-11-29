class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  def create
    unless current_course.free?
      # Amount in cents
      @amount = (current_course.cost * 100).to_i

      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })

      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: @amount,
        description: "Enrollment in '#{current_course.title}'",
        currency: 'usd',
      })
    end

    enrollment = current_user.enrollments.create(course: current_course)
    if enrollment.valid?
      redirect_to course_path(current_course)
    else
      flash[:error] = "Unable to enroll #{current_user.email} in '#{current_course.title}'"
      redirect_to root_path
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path
  end

  private

  def current_course
    @current_course ||= Course.find(params[:course_id])
  end
end
