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

  describe 'object' do
    context 'when object generate with FactoryBot' do
      let(:user) { build(:user) }

      it 'should be valid' do
        expect(user).to be_valid
      end

      it 'should save valid object' do
        expect { user.save! }.not_to raise_error
      end
    end
  end



end
