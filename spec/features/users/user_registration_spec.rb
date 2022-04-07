# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'user registration' do

  before(:each) do 
    User.destroy_all
  end

  it 'Can create a new user' do
    visit '/register'

    fill_in 'name', with: 'Ana'
    fill_in 'email', with: 'anita@hotmail.com'
    fill_in 'password', with: 'test'
    fill_in 'password_confirmation', with: 'test'
    click_on 'Submit'
    
    ana = User.last
    expect(current_path).to eq("/users/#{ana.id}")
  end
  
  describe 'user creation' do 
    it 'encrypts password' do 
      user = User.create(name: 'Meg', email: 'meg@test.com', password: 'password123', password_confirmation: 'password123')
      
      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('password123')
    end
    
    it 'creates a user when email is unique and passwords match' do 
      visit '/register'
    
      fill_in 'name', with: 'Steven'
      fill_in 'email', with: 'steven123@hotmail.com'
      fill_in 'password', with: 'password123'
      fill_in 'password_confirmation', with: 'password123'
      click_on 'Submit'

      expect(User.last.name).to eq('Steven')
    end
    
    it 'fails to create user if the email is not unique' do 
      user1 = User.create(name: 'Mike', email: 'test_email@hotmail.com', password: 'password123', password_confirmation: 'password123')
      visit '/register'
    
      fill_in 'name', with: 'Steven'
      fill_in 'email', with: 'test_email@hotmail.com'
      fill_in 'password', with: 'password123'
      fill_in 'password_confirmation', with: 'password123'
      click_on 'Submit'
  
      expect(User.last.name).to eq('Mike')      
      expect(User.last.name).to_not eq('Steven')
      expect(page).to have_content("Email has already been taken")
    end
    
    it 'fails to create user if passwords do not match' do 
      visit '/register'
    
      fill_in 'name', with: 'Steven'
      fill_in 'email', with: 'test_email@hotmail.com'
      fill_in 'password', with: 'password123'
      fill_in 'password_confirmation', with: 'wrong_password'
      click_on 'Submit'
  
      expect(User.all.count).to eq(0)
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end
