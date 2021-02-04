require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many associations', :aggregate_failures do
      is_expected.to have_many(:created_items)
      is_expected.to have_many(:comments)
      is_expected.to have_many(:reviews)
    end

    it 'has one associations', :aggregate_failures do
      is_expected.to have_one(:subscription)
    end
  end

  describe 'validations' do
    it 'has presence validate', :aggregate_failures do
      is_expected.to validate_presence_of(:nickname)
    end
  end

  # test with Capybara http://www.jessespevack.com/blog/2016/10/16/how-to-test-drive-omniauth-google-oauth2-for-your-rails-app
end
