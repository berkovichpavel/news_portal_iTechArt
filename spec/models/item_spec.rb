require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'associations' do
    it 'has many associations', :aggregate_failures do
      is_expected.to have_many(:comments)
      is_expected.to have_many(:reviews)
      is_expected.to have_many(:item_views).dependent(:destroy)
    end

    it 'has belong to associations', :aggregate_failures do
      is_expected.to belong_to(:author).optional
    end
  end

  describe 'validations' do
    it 'has presence validate', :aggregate_failures do
      is_expected.to validate_presence_of(:short_description)
      is_expected.to validate_presence_of(:full_text)
      is_expected.to validate_presence_of(:category)
      is_expected.to validate_presence_of(:mask)
      is_expected.to validate_presence_of(:status)
      is_expected.to validate_presence_of(:title)
    end

    it 'has length validate', :aggregate_failures do
      is_expected.to validate_length_of(:title).is_at_most(150)
      is_expected.to validate_length_of(:short_description).is_at_least(20).is_at_most(800)
      is_expected.to validate_length_of(:full_text).is_at_least(50)
    end
  end

  describe 'callbacks' do
    describe '#published_time' do
      let(:item) { create(:item, status: 'active') }

      it 'should change published_at to Time.current' do
        expect(item.published_at).not_to be_nil
      end

      it 'should change published_at to nil' do
        item.status = 'archive'
        item.save!
        expect(item.reload.published_at).to be_nil
      end
    end

    describe '#send_item_instantly' do
      let(:item) { build(:item) }

      it 'should call FindUsersInstantlyJob' do
        expect(item).to receive(:send_item_instantly)
        item.save
      end
    end
  end
end
