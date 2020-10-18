require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @challenge_read = challenges :read_each_month
    @challenge_burpees = challenges :burpees_each_day
    @ian = users :ian
  end

  test "a new user can login" do
    original_user_count = User.all.size
    visit new_user_registration_path
    within "form#new_user" do
      fill_in "user_email", with: "robot@testing.com"
      fill_in "user_password", with: "robotLOVEStests"
      fill_in "user_password_confirmation", with: "robotLOVEStests"
      click_on "Sign up"
    end
    expect(page).to have_content "Welcome! You have signed up successfully."
    assert_equal original_user_count + 1, User.all.size
  end
end
