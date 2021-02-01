require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'associations' do
    it 'has belong to associations', :aggregate_failures do
      is_expected.to belong_to(:user)
      is_expected.to belong_to(:item)
    end
  end

  describe 'validations' do
    it 'has presence validate', :aggregate_failures do
      is_expected.to validate_presence_of(:rating)
    end

    it 'has numericality validate', :aggregate_failures do
      is_expected.to validate_numericality_of(:rating)
    end
  end

  describe 'object' do
    context 'when object generate with FactoryBot' do
      let(:review) { build(:review) }

      it 'should be valid' do
        expect(review).to be_valid
      end

      it 'should save valid object' do
        expect { review.save! }.not_to raise_error
      end
    end
  end
end
