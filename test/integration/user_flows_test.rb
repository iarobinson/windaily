require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:ian)
  end

  test "user can sign in and sign out" do
    visit root_path
    click_link('Sign In', match: :first)

    within('form#new_user') do
      fill_in("user_email", with: @user.email)
      fill_in("user_password", with: "testing")
    end
    click_button "Log in"
    page.has_content? "Win Daily! Signed in successfully."
    click_link "Settings"
    click_link "Sign Out"

    page.has_content? "Win Daily! Signed out successfully."
  end
end
