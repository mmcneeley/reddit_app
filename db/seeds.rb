# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#create users
joe = User.create(username: "jayzonday", email: "joseph.moloughney@flatironschool.com")
henry = User.create(username: "kinghenryjr", email: "henry.zhang@flatironschool.com")
mike = User.create(username: "mmcneeley", email: "michael.mcneeley@flatironschool.com")

#posts
sports = Post.create(title: "yankees win!", user: joe)
movies = Post.create(title: "I love star wars", user: henry)
cars = Post.create(title: "someone busted my car! ugh", user: joe)
tech = Post.create(title: "I love to code, don't you?", user: mike)

#comments
Comment.create(content: 'great post!', user: joe, post: movies)
Comment.create(content: 'totally agree!', user: mike, post: sports)
Comment.create(content: 'loved this!', user: henry, post: tech)
