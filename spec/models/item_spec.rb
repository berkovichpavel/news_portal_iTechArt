require 'rails_helper'

RSpec.describe Item, type: :model do
  current_user = User.first_or_create!(email: 'example@gmail.com', password: '12345678', password_confirmation: '12345678', role: 'admin', first_name: 'first name', last_name: 'last name')
  it 'has a title' do
    item = Item.new(
      title: '',
      short_description: 'valid short_description',
      full_text: 'valid full text, but it should have more than 50 symbols',
      category: 'auto',
      mask: 'visible',
      author: current_user
    )
    expect(item).to_not be_valid
    item.title = 'Has a title'
    expect(item).to be_valid
  end
end
