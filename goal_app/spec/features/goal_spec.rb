require 'spec_helper'
require 'rails_helper'


feature 'creating goals' do
  background :each do
    user = User.create(username: "KD", password: "ilovesteph")
    visit user_url(user)
  end

  scenario 'takes a goal title and a completion date' do
    click_link "Add Goal"
    expect(page).to have_content('Title')
  end

  scenario 'redirects to user show page and displays goals' do
    # user = User.create(username: "Kevin", password: "ilovesteph")
    # visit user_url(user)

    click_link "Add Goal"
    fill_in "Title", with: "Make Breakfast"
    click_button "Create Goal"

    expect(current_url).to eq(user_url(user))
    expect(page).to have_content('Make Breakfast')
  end


end
