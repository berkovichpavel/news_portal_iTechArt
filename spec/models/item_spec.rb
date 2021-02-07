require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'associations' do
    it 'has many associations', :aggregate_failures do
      expect(subject).to have_many(:comments)
      expect(subject).to have_many(:reviews)
      expect(subject).to have_many(:item_views).dependent(:destroy)
    end

    it 'has belong to associations', :aggregate_failures do
      expect(subject).to belong_to(:author).optional
    end
  end

  describe 'validations' do
    it 'has presence validate', :aggregate_failures do
      expect(subject).to validate_presence_of(:short_description)
      expect(subject).to validate_presence_of(:full_text)
      expect(subject).to validate_presence_of(:category)
      expect(subject).to validate_presence_of(:mask)
      expect(subject).to validate_presence_of(:status)
      expect(subject).to validate_presence_of(:title)
    end

    it 'has length validate', :aggregate_failures do
      expect(subject).to validate_length_of(:title).is_at_most(150)
      expect(subject).to validate_length_of(:short_description).is_at_least(20).is_at_most(800)
      expect(subject).to validate_length_of(:full_text).is_at_least(50)
    end
  end

  describe 'callbacks' do
    describe '#published_time' do
      let(:item) { create(:item, status: 'active') }

      it 'changes published_at to Time.current' do
        expect(item.published_at).not_to be_nil
      end

      it 'changes published_at to nil' do
        item.status = 'archive'
        item.save!
        expect(item.reload.published_at).to be_nil
      end
    end

    describe '#send_item_instantly' do
      let(:item) { build(:item) }

      it 'calls FindUsersInstantlyJob' do
        expect(item).to receive(:send_item_instantly)
        item.save
      end
    end
  end
end
