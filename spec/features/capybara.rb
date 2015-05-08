require 'rails_helper'

RSpec.describe "the signin process", :type => :feature do
  before :each do
    @admin = FactoryGirl.create(:user_admin)
  end

  it "signs me in" do
    visit login_path #'/user_sessions/new.html'
    within('form') do
      fill_in 'Email', :with => @admin.email
      fill_in 'Password', :with => "123"
    end
    click_button 'Login'
    expect(page).to have_content 'Login successful'
  end
end
