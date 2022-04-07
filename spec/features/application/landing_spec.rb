# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Landing Page' do
  before(:each) do
    UserParty.destroy_all
    User.destroy_all
    ViewingParty.destroy_all
    @vp1 = ViewingParty.create!(movie_id: 111, duration: 151, date: Time.new(2022, 0o4, 12, 21, 0o0),
    start_time: Time.new(2022, 0o4, 12, 21, 0o0))
    @vp2 = ViewingParty.create!(movie_id: 112, duration: 152, date: Time.new(2022, 0o4, 11, 20, 30),
    start_time: Time.new(2022, 0o4, 11, 20, 30))
    @user1 = User.create!(name: 'Becky', email: 'becky@example.com', password: 'test', password_confirmation: 'test')
    @user2 = User.create!(name: 'Steven', email: 'steven@example.com', password: 'test', password_confirmation: 'test')
    @user5 = User.create!(name: 'Bruce', email: 'Bruce@example.com', password: 'test', password_confirmation: 'test')
    @user6 = User.create!(name: 'Tony', email: 'Tony@example.com', password: 'test', password_confirmation: 'test')
    @up1 = UserParty.create!(viewing_party: @vp1, user: @user1, host: true)
    @up2 = UserParty.create!(viewing_party: @vp1, user: @user2, host: false)
    @up5 = UserParty.create!(viewing_party: @vp2, user: @user5, host: true)
    @up6 = UserParty.create!(viewing_party: @vp2, user: @user6, host: false)
    
    visit '/'
  end
  
  it 'has the title of the application' do
    expect(page).to have_content('Viewing Party Light')
  end
  
  it 'has a link to the landing page', :vcr do
    expect(page).to have_link('Home')
    click_link('Home')
    expect(current_path).to eq('/')
  end

  it 'has a button to create a new user' do
    expect(page).to have_button('Create a New User')
    click_button('Create a New User')
    expect(current_path).to eq(new_user_path)
  end

  it 'has a button to login a user', :vcr do 
    expect(page).to have_button('Log In')
    click_button 'Log In'
    expect(current_path).to eq(login_form_path)
  end
  
  it 'does NOT have a list of existing users if logged out', :vcr do
    expect(page).to_not have_content(@user1.email)
    expect(page).to_not have_content(@user2.email)
    expect(page).to_not have_content(@user5.email)
    expect(page).to_not have_content(@user6.email)
  end

  it 'has a list of existing users if logged in', :vcr do
    visit login_form_path
    fill_in 'email', with: 'becky@example.com'
    fill_in 'password', with: 'test'
    click_button 'Submit'
    visit '/'

    within '#existing_users' do
      expect(page).to have_content(@user1.email)
      expect(page).to have_content(@user2.email)
      expect(page).to have_content(@user5.email)
      expect(page).to have_content(@user6.email)
    end
  end

  it 'has a button to log out a user after logging in ', :vcr do 
    visit login_form_path
    fill_in 'email', with: 'becky@example.com'
    fill_in 'password', with: 'test'
    click_button 'Submit'

    visit '/'

    expect(page).to have_button('Logout')
    click_button 'Logout'
    expect(current_path).to eq root_path
  end

  it 'unable to view user dashboard if logged out' do 
    expect(page).to have_button 'Log In'

    visit dashboard_path

    expect(current_path).to eq root_path
    expect(page).to have_content("Please login or register to access dashboard")
  end
end
