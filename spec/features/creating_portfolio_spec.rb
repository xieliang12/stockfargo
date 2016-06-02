require "rails_helper"

RSpec.feature "Users can create new portfolio" do
  before do
    visit "/portfolios"

    click_link "Create New Portfolio"
  end

  scenario "with valid attributes" do
    fill_in "name", with: "my portfolio"
    click_button "Create Portfolio"

    expect(page).to have_content "Portfolio has been created."

    portfolio = Portfolio.find_by(name: "my portfolio")
    expect(page.current_url).to eq portfolio_url(portfolio)
  end
  
  scenario "when providing invalid attributes" do
    click_button "Create Portfolio"

    expect(page).to have_content "Portfolio has not been created."
    expect(page).to have_content "Name can't be blank"
  end
end

