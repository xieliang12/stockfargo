require "rails_helper"

RSpec.feature "Users can create new portfolio" do
  scenario "with valid attributes" do
    visit "/"

    click_link "Create New Portfolio"

    fill_in "Enter the name of your portfolio", with: "my portfolio"
    click_button "Create"

    expect(page).to have_content "This portfolio is empty. Add a stock or mutual fund."
  end
end

