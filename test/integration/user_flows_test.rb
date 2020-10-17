require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  include AuthenticationHelper

  setup do
    @user = users(:ian)
  end

  test "user can sign in and sign out" do
    sign_in @user
    page.has_content? "Win Daily! Signed in successfully."
    click_link "Settings"
    click_link "Sign Out"

    page.has_content? "Win Daily! Signed out successfully."
  end
end
