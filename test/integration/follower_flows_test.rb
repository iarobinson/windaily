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

  test "a signed in user can follow another user" do
    sign_in @ian
    visit user_path @v
    page.has_content? "Follow"
  end
end
