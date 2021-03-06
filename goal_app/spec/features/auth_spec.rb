require 'spec_helper'
require 'rails_helper'

feature 'Sign Up' do
  background :each do
    visit new_user_path
  end

  scenario 'has a user sign up page' do
    expect(page).to have_content('Sign Up')
  end

  scenario 'takes a username and password' do
    expect(page).to have_content('Username')
    expect(page).to have_content('Password')
  end

  feature 'signing up a user' do
    scenario 'redirect to user\'s show page and displays the username' do
      fill_in 'Username', with: 'Kevin'
      fill_in 'Password', with: 'password'

      click_button 'Create User'
      expect(page).to have_content('Kevin')
      user = User.find_by(username: 'Kevin')
      expect(current_url).to eq(user_url(user))
    end
  end


end

feature 'log in' do
  background :each do
    visit new_session_path

  end

  scenario 'shows username on the homepage after login' do
    user = User.create(username: 'Kevin', password: 'password')
    fill_in 'Username', with: 'Kevin'
    fill_in 'Password', with: 'password'
    click_button 'Log In'

    expect(page).to have_content("Kevin")
  end

end

feature 'logging out' do
  background :each do
    visit new_session_path
    user = User.create(username: 'Kevin', password: 'password')
    fill_in 'Username', with: 'Kevin'
    fill_in 'Password', with: 'password'
    click_button 'Log In'
    click_button 'Log Out'
  end

  scenario 'begins with a logged out state' do
    expect(current_url).to eq(new_session_url)
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    expect(page).not_to have_content('Kevin')
  end
end
