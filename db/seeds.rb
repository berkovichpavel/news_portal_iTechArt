# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
require 'factory_bot'
User.create!([
               { email: 'admin@gmail.com', password: '12345678', role: 'admin', bio: 'Example of bio', first_name: 'Pavel', last_name: 'Berkovich', nickname: 'admin' },
               { email: 'redactor@gmail.com', password: '12345678', role: 'redactor', bio: 'Example of bio', first_name: 'Pavel', last_name: 'Erkovich', nickname: 'redactor' },
               { email: 'correspondent@gmail.com', password: '12345678', role: 'correspondent', bio: 'Example of bio', first_name: 'Pavel', last_name: 'Stashenko', nickname: 'correspondent' },
               { email: 'berkovich.pasha@gmail.com', password: '12345678', role: 'user', bio: 'Example of bio', first_name: 'Pavel', last_name: 'Berkovich', nickname: 'simple user' },
               { email: 'bp@gmail.com', password: '12345678', role: 'correspondent', bio: 'Example of bio', first_name: 'Pavel', last_name: 'Bertolet', nickname: 'correspondent Bertolet' },
               { email: 'Berk@gmail.com', password: '12345678', role: 'user', bio: 'Example of bio', first_name: 'Pavel', last_name: 'Bertolet', nickname: 'user' }
             ])
