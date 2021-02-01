FactoryBot.define do
  factory :item do
    title { 'Компания — владелец «Табакерок» перестала импортировать сигареты.' }
    short_description { 'Теперь на рынке остался один импортер сигарет, это «Беларусьторг» — предприятие Управделами президента. Узнали, что произошло.' }
    full_text { Faker::Hipster.sentences.sample + ' ' + Faker::Hipster.sentences.sample + ' ' + Faker::Hipster.sentences.sample }
    category { 'auto' }
    mask { 'visible' }
    status { 'active' }

    association :author, factory: :user
  end
end
