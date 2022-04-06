# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'user registration' do
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
end
