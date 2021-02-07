require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'associations' do
    it 'has belong to associations', :aggregate_failures do
      expect(subject).to belong_to(:user)
    end
  end

  describe 'validations' do
    it 'has presence validate', :aggregate_failures do
      expect(subject).to validate_presence_of(:sending_frequency)
    end

    it 'has numericality validate', :aggregate_failures do
      expect(subject).to validate_numericality_of(:dispatch_hour)
    end
  end

  describe 'callbacks' do
    describe '#change_dispatch_hour' do
      let(:subscription) { build(:subscription, sending_frequency: 'instantly') }

      it 'changes dispatch_hour to nil' do
        subscription.run_callbacks(:save)
        expect(subscription.dispatch_hour).to be_nil
      end
    end
  end
end
