require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it 'has belong to associations', :aggregate_failures do
      expect(subject).to belong_to(:user).optional
      expect(subject).to belong_to(:parent).optional
      expect(subject).to belong_to(:commentable)
    end
  end

  describe 'validations' do
    it 'has presence validate', :aggregate_failures do
      expect(subject).to validate_presence_of(:body)
    end
  end

  describe '#deleted' do
    context 'when user not nil' do
      let(:comment) { build(:comment) }

      it 'returns false' do
        expect(comment.deleted?).to be false
      end
    end

    context 'when user is nil' do
      let(:comment) { build(:comment, user: nil) }

      it 'returns true' do
        expect(comment.deleted?).to be true
      end
    end
  end

  describe '#destroy' do
    let(:comment) { build(:comment) }

    it 'changes user and body' do
      comment.destroy
      expect([comment.user, comment.body]).to eql([nil, '[deleted]'])
    end
  end

  describe '#comments' do
    let(:parent_comment) { create(:comment) }
    let(:comment) { create(:comment, parent_id: parent_comment.id, commentable: parent_comment.commentable) }

    it 'returns comment' do
      comment.save
      expect(parent_comment.comments.first).to eq(comment)
    end
  end
end
