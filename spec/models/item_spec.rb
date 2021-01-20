require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:current_user) { User.first_or_create!(email: 'example@gmail.com', password: '12345678', password_confirmation: '12345678', role: 'admin', first_name: 'first name', last_name: 'last name') }
  let(:item) do
    Item.new(
      title: title,
      short_description: description,
      full_text: full_text,
      category: category,
      mask: mask,
      author: author
    )
  end

  describe 'title validation' do
    context 'when title is blank' do
      let(:title) { '' }

      it 'is invalid' do
        expect(item).to_not be_valid
      end
    end

    context 'when title present' do
      let(:title) { 'Title' }

      it 'is valid' do
        expect(item).to be_valid
      end
    end
  end
end
