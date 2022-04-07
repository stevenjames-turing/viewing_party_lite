require 'rails_helper'

RSpec.describe 'User Login Form' do
  before(:each) do 
    User.destroy_all
    @user1 = User.create(name: 'Meg', email: 'meg@test.com', password: 'password123', password_confirmation: 'password123')
    visit login_form_path
  end

  it 'directs to user dashboard if user exists in the database' do 
    fill_in 'email', with: 'meg@test.com'
    fill_in 'password', with: 'password123'
    click_button 'Submit'
    expect(current_path).to eq(user_path(@user1.id))
  end
  
  it 'user must provide valid email address' do 
    fill_in 'email', with: 'steven@test.com'
    fill_in 'password', with: 'password123'
    click_button 'Submit'

    expect(current_path).to eq(login_form_path)
    expect(page).to have_content("Invalid Credentials")
  end
  
 
end
