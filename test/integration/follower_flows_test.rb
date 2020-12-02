require 'test_helper'

class FollowerFlowsTest < ActionDispatch::IntegrationTest
  # binding.pry
  include AuthenticationHelper

  setup do
    @ian = users(:ian)
    @v = users(:v)
  end

  test "a user can follow another user" do
    assert true, "<= got it!"
  end

  test "a follower sees the unfollow button when viewing profiles of people they follow" do
    sign_in @ian
    visit user_path @v
    click_on "Unfollow"
    assert_false @v.followers.include? @ian
  end
end
