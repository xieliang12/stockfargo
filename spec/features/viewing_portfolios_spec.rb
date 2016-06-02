require 'rails_helper'

RSpec.feature "Owners can view portfolios" do
  scenario "with the portolio details" do
    portfolio = FactoryGirl.create(:portfolio, name: "Value based")

    visit "/portfolios"
    click_link "Value based"
    expect(page.current_url).to eq portfolio_url(portfolio)
  end
end
