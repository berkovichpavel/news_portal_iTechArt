require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it 'has belong to associations', :aggregate_failures do
      is_expected.to belong_to(:user).optional
      is_expected.to belong_to(:parent).optional
      is_expected.to belong_to(:commentable)
    end
  end

  describe 'validations' do
    it 'has presence validate', :aggregate_failures do
      is_expected.to validate_presence_of(:body)
    end
  end

  describe 'object' do
    context 'when object generate with FactoryBot' do
      let(:comment) { build(:comment) }

      it 'should be valid' do
        expect(comment).to be_valid
      end

      it 'should save valid object' do
        expect { comment.save! }.not_to raise_error
      end
    end
  end

  describe '#deleted' do
    context 'when user not nil' do
      let(:comment) { build(:comment) }

      it 'should return false' do
        expect(comment.deleted?).to be false
      end
    end

    context 'when user is nil' do
      let(:comment) { build(:comment, user: nil) }

      it 'should return true' do
        expect(comment.deleted?).to be true
      end
    end
  end

  describe '#destroy' do
    let(:comment) { build(:comment) }

    it 'should change user and body' do
      comment.destroy
      expect([comment.user, comment.body]).to eql([nil, '[deleted]'])
    end
  end

  describe '#comments' do
    let(:parent_comment) { create(:comment) }
    let(:comment) { create(:comment, parent_id: parent_comment.id, commentable: parent_comment.commentable) }

    it 'should return comment' do
      comment.save
      expect(parent_comment.comments.first).to eq(comment)
    end

  end
end
