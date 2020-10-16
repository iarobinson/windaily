require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest

  test "visit root path" do
    visit root_path
    click_link('Sign In', match: :first)
    page.has_content? "Log in"
  end
end
