require 'faker'

Admin.create( email: 'ngocquyhoang.93@gmail.com', password: '123456789', password_confirmation: '123456789' )
User.create( email: 'ngocquyhoang.93@gmail.com', username: 'ngocquyhoang', name: 'Hoang Ngoc Quy', gender: 'male', password: '123456789', password_confirmation: '123456789' )

Message.create( name: 'Hoang Ngoc Quy', email: 'ngocquyhoang.93@gmail.com', message: Faker::Lorem.paragraph )
(1..9).each do |index|
  Message.create( name: Faker::Name.name , email: Faker::Internet.email, message: Faker::Lorem.paragraph )
end

EventType.create( label: 'Game' )
EventType.create( label: 'Entertainment' )
EventType.create( label: 'Ecucation' )
EventType.create( label: 'Charity' )
EventType.create( label: 'Volunteer' )
EventType.create( label: 'Sport' )
EventType.create( label: 'Blood Donation' )
