require 'rails_helper'

RSpec.feature 'user logs in', type: :feature do
  context 'create new user' do
    scenario 'should be successful' do
      user = FactoryBot.create(:user, email: 'berkovich.pasha@gmail.com' )
      user.skip_confirmation!

      visit new_user_session_path
      within('form') do
        fill_in 'user_email', with: 'berkovich.pasha@gmail.com'
        fill_in 'user_password', with: user.password
      end
      click_button 'button'
      expect(page).to have_content('Signed in successfully.')
    end
  end

end
