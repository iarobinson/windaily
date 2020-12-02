require 'test_helper'

class FollowerFlowsTest < ActionDispatch::IntegrationTest
  include AuthenticationHelper

  setup do
    @ian = users(:ian)
    @v = users(:v)
  end

  scenario "a user can follow another user" do
    assert false, "<= got it!"
  end

end
