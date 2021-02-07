require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'associations' do
    it 'has belong to associations', :aggregate_failures do
      expect(subject).to belong_to(:user)
      expect(subject).to belong_to(:item)
    end
  end

  describe 'validations' do
    it 'has presence validate', :aggregate_failures do
      expect(subject).to validate_presence_of(:rating)
    end

    it 'has numericality validate', :aggregate_failures do
      expect(subject).to validate_numericality_of(:rating)
    end
  end
end
