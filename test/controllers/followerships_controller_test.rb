require 'test_helper'

class FollowershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @followership = followerships(:one)
  end

  # test "should get index" do
  #   get followerships_url
  #   assert_response :success
  # end
  #
  # test "should get new" do
  #   get new_followership_url
  #   assert_response :success
  # end
  #
  # test "should create followership" do
  #   assert_difference('Followership.count') do
  #     post followerships_url, params: { followership: { friend_id: @followership.friend_id, user_id: @followership.user_id } }
  #   end
  #
  #   assert_redirected_to followership_url(Followership.last)
  # end

  # test "should show followership" do
  #   get followership_url(@followership)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_followership_url(@followership)
  #   assert_response :success
  # end
  #
  # test "should update followership" do
  #   patch followership_url(@followership), params: { followership: { follower_id: @followership.friend_id, user_id: @followership.user_id } }
  #   assert_redirected_to followership_url(@followership)
  # end
  #
  # test "should destroy followership" do
  #   assert_difference('Followership.count', -1) do
  #     delete followership_url(@followership)
  #   end
  #
  #   assert_redirected_to followerships_url
  # end
end
