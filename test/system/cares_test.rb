require "application_system_test_case"

class CaresTest < ApplicationSystemTestCase
  setup do
    @care = cares(:one)
  end

  test "visiting the index" do
    visit cares_url
    assert_selector "h1", text: "Cares"
  end

  test "creating a Care" do
    visit cares_url
    click_on "New Care"

    fill_in "Fed", with: @care.fed
    fill_in "Medicated", with: @care.medicated
    click_on "Create Care"

    assert_text "Care was successfully created"
    click_on "Back"
  end

  test "updating a Care" do
    visit cares_url
    click_on "Edit", match: :first

    fill_in "Fed", with: @care.fed
    fill_in "Medicated", with: @care.medicated
    click_on "Update Care"

    assert_text "Care was successfully updated"
    click_on "Back"
  end

  test "destroying a Care" do
    visit cares_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Care was successfully destroyed"
  end
end
