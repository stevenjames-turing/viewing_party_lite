# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'movie show page' do
  before(:each) do
    @user1 = User.create!(name: 'Becky', email: 'becky@example.com', password: 'test')
    visit login_form_path
    fill_in 'email', with: 'becky@example.com'
    fill_in 'password', with: 'test'
    click_button 'Submit'
    @movie1 = Movie.new(title: 'Scarface', id: 111, runtime: 170, vote_average: 8.2, summary: 'After getting a green card in exchange for assassinating a Cuban government official, Tony Montana stakes a claim on the drug trade in Miami. Viciously murdering anyone who stands in his way, Tony eventually becomes the biggest drug lord in the state, controlling nearly all the cocaine that comes through Miami. But increased pressure from the police, wars with Colombian drug cartels and his own drug-fueled paranoia serve to fuel the flames of his eventual downfall.', poster: '/32pLDObtIt2MJcdPG9mQKuybImL.jpg', genres: [
                          {
                            "id": 28,
                            "name": 'Action'
                          },
                          {
                            "id": 80,
                            "name": 'Crime'
                          },
                          {
                            "id": 18,
                            "name": 'Drama'
                          },
                          {
                            "id": 53,
                            "name": 'Thriller'
                          }
                        ])

    visit movie_path(@movie1.id)
  end
  
  it 'has a button to create a viewing party', :vcr do
    click_button('Create Viewing Party for Scarface')
  end
  
  it 'displays the movie title', :vcr do
    expect(page).to have_content('Scarface')
  end
  
  it "display's the movie's vote average", :vcr do
    expect(page).to have_content('Vote Average: 8.2')
  end
  
  it "displays the movie's runtime", :vcr do
    expect(page).to have_content('Runtime: 170mins')
  end
  
  it "displays the movie's summary", :vcr do
    expect(page).to have_content('After getting a green card in exchange for assassinating a Cuban government official, Tony Montana stakes a claim on the drug trade in Miami. Viciously murdering anyone who stands in his way, Tony eventually becomes the biggest drug lord in the state, controlling nearly all the cocaine that comes through Miami. But increased pressure from the police, wars with Colombian drug cartels and his own drug-fueled paranoia serve to fuel the flames of his eventual downfall.')
  end
  
  it 'has a button to return to Discover page', :vcr do
    expect(page).to have_button('Discover Page')
    
    click_button('Discover Page')
    
    expect(current_path).to eq(discover_index_path)
  end
  
  it 'user must be logged in to create a viewing party', :vcr do 
    click_button 'Logout'
    
    visit movie_path(@movie1.id)
    click_button('Create Viewing Party for Scarface')
    expect(current_path).to eq(movie_path(@movie1.id))
    expect(page).to have_content("You must be logged in or registered to create a viewing party")
  end
end
