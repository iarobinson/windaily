require "application_system_test_case"

class FriendshipsTest < ApplicationSystemTestCase
  setup do
    @friendship = friendships(:one)
  end

  test "visiting the index" do
    visit friendships_url
    assert_selector "h1", text: "Friendships"
  end

  test "creating a Friendship" do
    visit friendships_url
    click_on "New Friendship"

    fill_in "Create", with: @friendship.create
    fill_in "Destroy", with: @friendship.destroy
    fill_in "Friend", with: @friendship.friend_id
    fill_in "User", with: @friendship.user_id
    click_on "Create Friendship"

    assert_text "Friendship was successfully created"
    click_on "Back"
  end

  test "updating a Friendship" do
    visit friendships_url
    click_on "Edit", match: :first

    fill_in "Create", with: @friendship.create
    fill_in "Destroy", with: @friendship.destroy
    fill_in "Friend", with: @friendship.friend_id
    fill_in "User", with: @friendship.user_id
    click_on "Update Friendship"

    assert_text "Friendship was successfully updated"
    click_on "Back"
  end

  test "destroying a Friendship" do
    visit friendships_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Friendship was successfully destroyed"
  end
end
