require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CoursesHelper. For example:
#
# describe CoursesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe CoursesHelper, type: :helper do
  describe "courses#show action" do
    it "should successfully show a course details page" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end
end
