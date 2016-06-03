require 'rails_helper'

RSpec.describe PortfoliosController, type: :controller do
  it "handles a missing portolio correctly" do
    get :show, id: "not-here"

    expect(response).to redirect_to(portfolios_path)

    message = "The portfolio you were looking for could not be found."
    expect(flash[:alert]).to eq message
  end
end
