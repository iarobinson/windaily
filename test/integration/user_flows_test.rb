require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  include AuthenticationHelper

  setup do
    @user = users(:ian)
  end

  test "user can sign in and sign out" do
    sign_in @user
    page.has_content? "Signed in successfully."
    visit edit_user_registration_path @user
    click_link "Sign Out"
    page.has_content? "Signed out successfully."
  end

  test "user can create a challenge, add friends and record wins" do
    create_new_user
    visit new_challenge_path
    within "form" do
      fill_in "challenge_title", with: "Test Challenge"
      fill_in "challenge_description", with: "This is the description for a test challenge"
      fill_in "challenge_frequency", with: "test frequency daily"
      select "Public"
      click_on "Create Challenge"
    end
    page.has_content? "Challenge was successfully created."
    click_on "Record a Win", match: :first
    within "form" do
      fill_in "win_title", with: "title for the first win of the test challenge"
      fill_in "win_description", with: "the win description goes here"
      click_on "Save"
    end
    page.has_content? "Win was successfully saved for this challenge."
    page.has_content? "title for the first win of the test challenge"
    assert_equal Challenge.last.title, "Test Challenge"
    # TODO this still needs work
  end

  test "user can use forgot password processs" do
    # TODO
    # assert_equal fail
  end
end
