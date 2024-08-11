require "application_system_test_case"

class CabinsTest < ApplicationSystemTestCase
  setup do
    @cabin = cabins(:one)
  end

  test "visiting the index" do
    visit cabins_url
    assert_selector "h1", text: "Cabins"
  end

  test "should create cabin" do
    visit cabins_url
    click_on "New cabin"

    fill_in "Description", with: @cabin.description
    fill_in "Image", with: @cabin.image
    fill_in "Name", with: @cabin.name
    fill_in "Price", with: @cabin.price
    click_on "Create Cabin"

    assert_text "Cabin was successfully created"
    click_on "Back"
  end

  test "should update Cabin" do
    visit cabin_url(@cabin)
    click_on "Edit this cabin", match: :first

    fill_in "Description", with: @cabin.description
    fill_in "Image", with: @cabin.image
    fill_in "Name", with: @cabin.name
    fill_in "Price", with: @cabin.price
    click_on "Update Cabin"

    assert_text "Cabin was successfully updated"
    click_on "Back"
  end

  test "should destroy Cabin" do
    visit cabin_url(@cabin)
    click_on "Destroy this cabin", match: :first

    assert_text "Cabin was successfully destroyed"
  end
end
