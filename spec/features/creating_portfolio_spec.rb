require "rails_helper"

RSpec.feature "Users can create new portfolio" do
  scenario "with valid attributes" do
    visit "/portfolios"

    click_link "Create New Portfolio"

    fill_in "name", with: "my portfolio"
    click_button "Create"

    expect(page).to have_content "Portfolio has been created."
  end
end

