require 'test_helper'

class FollowerFlowsTest < ActionDispatch::IntegrationTest
  include AuthenticationHelper

  setup do
    @ian = users(:ian)
    @v = users(:v)
  end

  test "users can follow and unfollow eachother" do
    assert @v.followers.include? @ian
    sign_in @ian
    visit user_path @v
    click_on "Unfollow"
    @v.reload
    assert @v.followers.include?(@ian) == false
    click_on "Follow"
    assert @v.followers.include? @ian
  end
end
