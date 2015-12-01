require "rails_helper"

RSpec.describe Card, :type => :model do
  
  before(:each) do
    @card = create(:card)
    @value = Date.current + 3.days
  end

  it "check that original and translated text not equal" do
    expect(@card.original_text).not_to eq(@card.translated_text)
  end
  
  it "check that date change after card update" do
    @card.auto_date
    expect(@card.review_date).to eq(@value)
  end
  
  it "check that when card check date change" do
    @card.check_card(@card.original_text)
    expect(@card.review_date).to eq(@value)
  end
  
  it "check that input text not equal to original text" do
    expect(@card.check_card("new ot input")).to be false
  end

  it "check that input text equal to original text" do
    expect(@card.check_card("original_text")).to be true
  end

  it "feature test, check that card check" do
    visit root_path
    fill_in :translate, with: "original_text"
    click_button "Проверить"
    expect(page).to have_content "Молодец!"
  end

  it "feature test, check that card check failed" do
    visit root_path
    fill_in :translate, with: "wrong ot"
    click_button "Проверить"
    expect(page).to have_content "Не правильно"
  end

end