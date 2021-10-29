require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include AuthenticationHelper

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
    assert page.has_content? "Welcome! You have signed up successfully."
    assert_equal original_user_count + 1, User.all.size
  end

  test "a new visitor can create a challenge and invite a friend via email" do
    visit root_path
    page.find_link("home_page_create_challenge_button").click
    within("form") do
      fill_in "challenge_title", with: "Say something lovely to your lady"
      fill_in "challenge_description", with: "We are going to keep the ladies happy brother. Wins will be short descriptions of what you said/did."
      # fill_in "challenge_frequency", with: "daily"
      fill_in "challenge_email", with: "test_email@windaily.app"
      click_on "Create Challenge"
    end

    page.has_content? "PLEASE SET YOUR PASSWORD:"
    @new_user = User.where(email: "test_email@windaily.app").first
    @new_challenge = @new_user.challenges.first
    assert_equal 1, @new_user.challenges.size

    visit challenge_path @new_user.challenges.first
    click_on "Add a Friend"
    within("form") do
      fill_in "user_email", with: "test_fried@elsewhere.com"
      click_on "Add a Friend"
    end

    visit challenge_path @new_user.challenges.first
    click_on 'Add a Friend'
    within("form#new_user_form") do
      fill_in "user_phone", with: "test_fried@elsewhere.com"
      click_on "Add a Friend"
    end
    assert_equal @new_challenge.users.size, 3
  end
end
