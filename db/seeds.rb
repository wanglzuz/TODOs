# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user1 = User.create({name: 'Applifter', email: 'info@applifting.com',
                     access_token: '93f39e2f-80de-4033-99ee-249d92736a25'})

user2 = User.create({name: 'Batman', email: 'batman@applifting.com',
                     access_token: 'dcb20f8a-5657-4f1b-9f7f-ce65739b359e'})

todo1 = Todo.create({text: 'Ongoing TODO.', created: DateTime.now, done: false, user: user1})
todo2 = Todo.create({text: 'Done TODO.', created: DateTime.now, done: true, user: user1})