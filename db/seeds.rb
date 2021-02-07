require 'factory_bot'
Item.__elasticsearch__.create_index!(force: true)

require 'factory_bot_rails'

User.create!([
               { email: 'admin@gmail.com', password: '12345678', role: 'admin', bio: 'Example of bio', first_name: 'Denis', last_name: 'Berkovich', nickname: 'admin' },
               { email: 'redactor@gmail.com', password: '12345678', role: 'redactor', bio: 'Example of bio', first_name: 'Vsa', last_name: 'Erkovich', nickname: 'redactor' },
               { email: 'correspondent@gmail.com', password: '12345678', role: 'correspondent', bio: 'Example of bio', first_name: 'Pavel', last_name: 'Stashenko', nickname: 'correspondent' },
               { email: 'berkovich.pasha@gmail.com', password: '12345678', role: 'user', bio: 'Example of bio', first_name: 'Pavel', last_name: 'Berkovich', nickname: 'simple user' },
               { email: 'bp@gmail.com', password: '12345678', role: 'correspondent', bio: 'Example of bio', first_name: 'Roma', last_name: 'Bertolet', nickname: 'correspondent Bertolet' },
               { email: 'berk@gmail.com', password: '12345678', role: 'user', bio: 'Example of bio', first_name: 'Kolya', last_name: 'Bertolet', nickname: 'user' }
             ])

25.times { FactoryBot.create(:item_with_comments_and_reviews) }
