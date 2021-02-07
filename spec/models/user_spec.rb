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
      is_expected.to validate_presence_of(:role)
    end
  end

  describe '.from_omniauth' do
    let(:auth) do
      { provider: 'github',
        uid: '66945592',
        info: {
          nickname: 'JesseSpervak2000',
          email: 'jesse@mountainmantechnologies.com',
          name: 'Jesse Spevack'
        } }
    end
    it 'creates or updates itself from an oauth hash' do
      User.from_omniauth(auth)
      new_user = User.last
      expect(new_user.provider).to eq('github')
      expect(new_user.uid).to eq('66945592')
      expect(new_user.email).to eq('jesse@mountainmantechnologies.com')
      expect(new_user.nickname).to eq('JesseSpervak2000')
      expect(new_user.first_name).to eq('Jesse')
      expect(new_user.last_name).to eq('Spevack')
    end
  end
end
