require "application_system_test_case"

class NjsTest < ApplicationSystemTestCase
  setup do
    @nj = njs(:one)
  end

  test "visiting the index" do
    visit njs_url
    assert_selector "h1", text: "Njs"
  end

  test "creating a Nj" do
    visit njs_url
    click_on "New Nj"

    fill_in "Address", with: @nj.address
    fill_in "Description", with: @nj.description
    fill_in "Name", with: @nj.name
    check "Verified" if @nj.verified
    click_on "Create Nj"

    assert_text "Nj was successfully created"
    click_on "Back"
  end

  test "updating a Nj" do
    visit njs_url
    click_on "Edit", match: :first

    fill_in "Address", with: @nj.address
    fill_in "Description", with: @nj.description
    fill_in "Name", with: @nj.name
    check "Verified" if @nj.verified
    click_on "Update Nj"

    assert_text "Nj was successfully updated"
    click_on "Back"
  end

  test "destroying a Nj" do
    visit njs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Nj was successfully destroyed"
  end
end
