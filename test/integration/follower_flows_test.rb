require 'test_helper'

class FollowerFlowsTest < ActionDispatch::IntegrationTest
  include AuthenticationHelper

  setup do
    @ian = users(:ian)
    @v = users(:v)
  end

  test "a user can follow another user" do
    assert false, "<= got it!"
  end

end
