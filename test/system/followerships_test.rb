require "application_system_test_case"

class FollowershipsTest < ApplicationSystemTestCase
  setup do
    @followership = followerships(:one)
  end

  test "visiting the index" do
    visit followerships_url
    assert_selector "h1", text: "Followerships"
  end

  test "creating a Followership" do
    visit followerships_url
    click_on "New Followership"

    fill_in "Friend", with: @followership.friend_id
    fill_in "User", with: @followership.user_id
    click_on "Create Followership"

    assert_text "Followership was successfully created"
    click_on "Back"
  end

  test "updating a Followership" do
    visit followerships_url
    click_on "Edit", match: :first

    fill_in "Friend", with: @followership.friend_id
    fill_in "User", with: @followership.user_id
    click_on "Update Followership"

    assert_text "Followership was successfully updated"
    click_on "Back"
  end

  test "destroying a Followership" do
    visit followerships_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Followership was successfully destroyed"
  end
end
