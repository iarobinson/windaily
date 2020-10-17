require 'test_helper'

class ChallengesControllerTest < ActionDispatch::IntegrationTest
  include AuthenticationHelper

  setup do
    @challenge = challenges(:read_each_month)
    @ian = users(:ian)
  end
  
  test "should get index" do
    visit challenges_url
    expect(page).to have_content "All Challenges"
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
    expect(page).to have_content "Win Daily! Challenge was successfully created."
    expect(page).to have_content "TITLE of Challenge TK"
  end

  test "should show challenge" do
    visit challenge_path @challenge
    expect(page).to have_content @challenge.title
  end

  test "should get edit" do
    sign_in @ian
    visit challenge_path @challenge
    click_on "Join"
    click_on "View Challenge"
    click_on "Edit"
  end

  # test "should update dummy" do
  #   patch dummy_url(@dummy), params: { dummy: {  } }
  #   assert_redirected_to dummy_url(@dummy)
  # end
  #
  # test "should destroy dummy" do
  #   assert_difference('Dummy.count', -1) do
  #     delete dummy_url(@dummy)
  #   end
  #
  #   assert_redirected_to dummies_url
  # end
end
