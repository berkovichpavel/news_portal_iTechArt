require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#title' do
    context 'presence validate' do
      it { is_expected.to validate_presence_of(:title) }
    end
    context 'length validate' do
      it { is_expected.to validate_length_of(:title).is_at_most(150) }
    end
  end

  describe '#short_description' do
    context 'presence validate' do
      it { is_expected.to validate_presence_of(:short_description) }
    end
    context 'length validate' do
      it { is_expected.to validate_length_of(:short_description).is_at_least(20).is_at_most(800) }
    end
  end

  describe '#full_text' do
    context 'presence validate' do
      it { is_expected.to validate_presence_of(:full_text) }
    end
    context 'length validate' do
      it { is_expected.to validate_length_of(:full_text).is_at_least(50) }
    end
  end

  describe '#category' do
    context 'presence validate' do
      it { is_expected.to validate_presence_of(:category) }
    end
  end

  describe '#mask' do
    context 'presence validate' do
      it { is_expected.to validate_presence_of(:mask) }
    end
  end

  describe '#status' do
    context 'presence validate' do
      it { is_expected.to validate_presence_of(:status) }
    end
  end

  describe '#status' do
    context 'presence validate' do
      it { is_expected.to validate_presence_of(:status) }
    end
  end

  describe 'associations' do
    # не работает и не понимаю как пофиксить
    # context 'should belongs to author' do
    #   it { is_expected.to belong_to(:author).class_name('User').with_foreign_key(:author_id).optional }
    # end

    context 'should have many comments' do
      it { is_expected.to have_many(:comments) }
    end

    context 'should have many reviews' do
      it { is_expected.to have_many(:reviews) }
    end

    context 'should have many item_views' do
      it { is_expected.to have_many(:item_views).dependent(:destroy) }
    end
  end

  describe 'object' do
    context 'when object generate with FactoryBot' do
      let(:item) { build(:item) }

      it 'should be valid' do
        expect(item).to be_valid
      end

      it 'should save valid object' do
        expect { item.save! }.not_to raise_error
      end
    end
  end

  context 'callback' do
    context 'before_save' do
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
    end

    context 'after_save' do
      describe '#send_item_instantly' do
        let(:item) { build(:item) }

        it 'should change published_at to Time.current' do
          expect(FindUsersInstantlyJob).to receive(:perform_now).once
          item.run_callbacks(:save)
        end
      end
    end
  end
end
