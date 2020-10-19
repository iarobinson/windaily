require 'test_helper'

class ChallengesControllerTest < ActionDispatch::IntegrationTest
  include AuthenticationHelper

  setup do
    @challenge_read = challenges :read_each_month
    @challenge_burpees = challenges :burpees_each_day
    @ian = users :ian
  end

  test "should get index" do
    get challenges_url @challenge_burpees
    assert_response :success
  end

  test "should get new" do
    get new_challenge_url
    assert_response :success
  end

  test "should create challenge" do
    sign_in @ian

    visit new_challenge_path
    within "form" do
      fill_in "challenge_title", with: "TITLE of Challenge TK"
      fill_in "challenge_description", with: "DESCRIPTION of Challenge TK"
      fill_in "challenge_frequency", with: "FREQUENCY of Challenge TK"
      click_on "Create Challenge"
    end
    expect(page).to have_content "Challenge was successfully created."
    expect(page).to have_content "TITLE of Challenge TK"
  end

  test "should show challenge" do
    visit challenge_path @challenge_read
    expect(page).to have_content @challenge_read.title
  end

  test "should get edit" do
    sign_in @ian
    visit challenge_path @challenge_read
    click_on "Join"
    click_on "View Challenge"
    click_on "Edit"
  end

  test "should update challenge" do
    sign_in_user_and_edit_challenge
    within "form" do
      fill_in "challenge_title", with: "Do One-hundred Burpees a Day UPDATED!"
      click_on "Update"
    end
    expect(page).to have_content "Challenge was successfully updated."
    expect(page).to have_content "Do One-hundred Burpees a Day UPDATED!"
  end

  test "should destroy challenge and it's associated wins" do
    original_challenge_count = Challenge.all.size
    original_challenge_win_count = @challenge_burpees.wins.all.size
    original_win_count = Win.all.size

    sign_in_user_and_edit_challenge
    click_on "Destroy this Challenge and All it's Wins Forever"
    assert_equal original_challenge_count - 1, Challenge.all.size
    assert_equal original_win_count - original_challenge_win_count, Win.all.size
  end

  def sign_in_user_and_edit_challenge
    sign_in @ian
    visit edit_challenge_url @challenge_burpees
  end
end
