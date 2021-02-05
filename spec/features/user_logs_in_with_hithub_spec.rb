require 'rails_helper'

RSpec.feature 'user logs in' do
  # test with Capybara http://www.jessespevack.com/blog/2016/10/16/how-to-test-drive-omniauth-google-oauth2-for-your-rails-app
  scenario 'using github' do
    stub_omniauth
    visit new_user_session_path
    expect(page).to have_link('Sign in with Github')
    click_link 'Sign in with Github'
    expect(page).to have_link('Exit')
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
                                                                  provider: 'github',
                                                                  uid: '66945592',
                                                                  info: {
                                                                    nickname: 'JesseSpervak2000',
                                                                    email: 'jesse@mountainmantechnologies.com',
                                                                    name: 'Jesse Spevack',
                                                                  },
                                                                  credentials: {
                                                                    token: 'abcdefg12345',
                                                                    refresh_token: '12345abcdefg',
                                                                    expires_at: DateTime.now
                                                                  }
                                                                })
  end
end
