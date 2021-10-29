require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  include AuthenticationHelper

  setup do
    @ian = users(:ian)
  end

  test "user can sign in and sign out" do
    sign_in @ian
    page.has_content? "Signed in successfully."
    visit edit_user_registration_path @ian
    click_link "Sign Out"
    page.has_content? "Signed out successfully."
  end

  test "user can create a challenge, add friends and record wins" do
    create_new_user
    visit new_challenge_path
    within "form#new_challenge_form" do
      fill_in "challenge_title", with: "Test Challenge"
      fill_in "challenge_description", with: "This is the description for a test challenge"
      # fill_in "challenge_frequency", with: "test frequency daily"
      # select "Public"
      click_on "Create Challenge"
    end
    page.has_content? "Challenge was successfully created."
    click_on "Record a Win", match: :first
    within "form" do
      fill_in "win_title", with: "title for the first win of the test challenge"
      fill_in "win_description", with: "the win description goes here"
      click_on "Save"
    end
    page.has_content? "Your win has been logged."
    page.has_content? "title for the first win of the test challenge"
    assert_equal Challenge.last.title, "Test Challenge"
    # TODO this still needs work
  end

  test "existing user can invite another via email and the new user can sign in" do
    sign_in @ian
    visit add_path
    within "form#new_user_form" do
      fill_in "user_email", with: "robot-email@testing.com"
      click_on "Add a Friend"
    end
    page.has_content? "robot-email@testing.com have been sent an email with your challenge."
    new_user = User.last
    assert_equal new_user.email, "robot-email@testing.com"
    sign_out @ian
    sign_in new_user
  end

  test "existing user can invite another via email on add page" do
    sign_in @ian
    visit add_path
    within "form#new_user_form" do
      fill_in "user_email", with: "robot-email2@testing.com"
      click_on "Add a Friend"
    end
    page.has_content? "robot-email@testing.com have been sent an email with your challenge."
    new_user = User.last
    assert_equal new_user.email, "robot-email2@testing.com"
    sign_out @ian
    sign_in new_user
  end

  test "existing user can invite another via text on add page" do
    sign_in @ian
    visit add_path
    within "form#new_user_form" do
      fill_in "user_phone", with: "1212121212"
      click_on "Add a Friend"
    end
    assert page.has_content? "1212121212 has been sent an invite", "Should be readable<-"

  end
end
