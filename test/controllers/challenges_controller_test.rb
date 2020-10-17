require 'test_helper'

class ChallengesControllerTest < ActionDispatch::IntegrationTest
  include AuthenticationHelper
  setup do
    @challenge = challenges(:burpees_each_day)
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
    sign_in

    assert_redirected_to challenges_url(Challenge.last)
  end

  # test "should show dummy" do
  #   get dummy_url(@dummy)
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get edit_dummy_url(@dummy)
  #   assert_response :success
  # end
  #
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
