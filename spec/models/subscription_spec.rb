require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'associations' do
    it 'has belong to associations', :aggregate_failures do
      is_expected.to belong_to(:user)
    end
  end

  describe 'validations' do
    it 'has presence validate', :aggregate_failures do
      is_expected.to validate_presence_of(:sending_frequency)
    end

    it 'has numericality validate', :aggregate_failures do
      is_expected.to validate_numericality_of(:dispatch_hour)
    end
  end

  describe 'object' do
    context 'when object generate with FactoryBot' do
      let(:subscription) { build(:subscription) }

      it 'should be valid' do
        expect(subscription).to be_valid
      end

      it 'should save valid object' do
        expect { subscription.save! }.not_to raise_error
      end
    end
  end


  describe 'callbacks' do
    describe '#change_dispatch_hour' do
      let(:subscription) { build(:subscription) }

      it 'should change dispatch_hour to nil' do
        subscription.run_callbacks(:save)
        expect(subscription.dispatch_hour).to be_nil
      end
    end
  end
end
