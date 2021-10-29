require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "pricing page is displayed" do
    visit pricing_path
    assert page.has_content? "Pricing"
  end
end
