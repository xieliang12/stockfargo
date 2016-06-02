require "rails_helper"

RSpec.feature "Owners can delete portfolios" do
  scenario "deleted succesfully" do
    FactoryGirl.create(:portfolio, name: "My portfolio 1")
    
    visit "/portfolios"
    click_link "My portfolio 1"
    click_link "Delete Portfolio"

    expect(page).to have_content "Portfolio has been deleted."
    expect(page.current_url).to eq portfolios_url
    expect(page).to have_no_content "My portfolio 1"
  end
end
