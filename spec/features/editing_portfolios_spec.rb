require 'rails_helper'

RSpec.feature "Owners can edit existing portfolios" do
  before do
    FactoryGirl.create(:portfolio, name: "my first portfolio")

    visit "/portfolios"
    click_link "my first portfolio"
    click_link "Edit Portfolio"
  end

  scenario "with valid attributes" do
    fill_in "name", with: "my second portfolio"
    click_button "Update Portfolio"

    expect(page).to have_content "Portfolio has been updated."
    expect(page).to have_content "my second portfolio"
  end

  scenario "when providing invalid attributes" do
    fill_in "name", with: ""
    click_button "Update Portfolio"

    expect(page).to have_content "Portfolio has not been updated."
  end
end
