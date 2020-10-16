require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:ian)
  end

  test "visit root path" do
    visit root_path
    click_link('Sign In', match: :first)
    within('form#new_user') do
      fill_in("user_email", with: @user.email)
      fill_in("user_password", with: @user.password)
    end
    # binding.pry
    click_button "Log in"
    page.has_content? "Win Daily! Signed in successfully."
  end
end
