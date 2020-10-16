require "application_system_test_case"

class ChallengesTest < ApplicationSystemTestCase
  include AuthenticationHelper

  setup do
    @challenge = challenges(:burpees_each_day)
    @ian = users(:ian)
  end

  test "visiting the index" do
    visit challenges_url
    assert_selector "h2", text: "All Challenges"
  end

  test "creating a Challenge" do
    visit challenges_url
    click_on "New Challenge"

    click_on "Create Challenge"

    assert_text "Challenge was successfully created"
    click_on "Back"
  end

  test "updating a Challenge" do
    sign_in @ian
    visit challenges_url
    click_on "Show", match: :first
    click_on "Join"
    click_on "View Challenge"
    click_on "Edit"
    # within('#challenge_title') do
      fill_in("Read One Book a Week!")
    # end
    click_on "Update Challenge"

    assert_text "Challenge was successfully updated"
    assert_text "Read One Book a Week!"
  end

  # TODO: Write a test to destroy a challenge
  # test "destroying a Challenge" do
  #   visit challenges_url
  #   page.accept_confirm do
  #     click_on "Join", match: :first
  #     page.accept_confirm do
  #       click_on "Join", match: :first
  #     end
  #   end
  #
  #   assert_text "Challenge was successfully destroyed"
  # end
end
