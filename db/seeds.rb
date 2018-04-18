# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#create users
joe = User.create(username: "jayzonday", email: "joseph.moloughney@flatironschool.com", password:"123")
henry = User.create(username: "kinghenryjr", email: "henry.zhang@flatironschool.com", password:"1234")
mike = User.create(username: "mmcneeley", email: "michael.mcneeley@flatironschool.com", password:"12345")


#topics
technology = Topic.create(name: "Technology")
sports = Topic.create(name: "Sports")
movies = Topic.create(name: "Movies")
cars = Topic.create(name: "Cars")
food = Topic.create(name: "Food")
health = Topic.create(name: "Health")
lifestyle = Topic.create(name: "Lifestyle")


#posts
yankees = Post.create(title: "yankees win!", user: joe, topic: sports)
movie_review = Post.create(title: "I love star wars", user: henry, topic: movies)
car_accident = Post.create(title: "someone busted my car! ugh", user: joe, topic: cars)
love_code = Post.create(title: "I love to code, don't you?", user: mike, topic: technology)

#comments
Comment.create(content: 'great post!', user: joe, post: movie_review)
Comment.create(content: 'totally agree!', user: mike, post: yankees)
Comment.create(content: 'loved this!', user: henry, post: love_code)

#votes
Vote.create(value: 1, post: yankees, user: mike)
Vote.create(value: 1, post: yankees, user: joe)
Vote.create(value: -1, post: yankees, user: henry)
Vote.create(value: 1, post: love_code, user: mike)
Vote.create(value: 1, post: love_code, user: joe)

#tags
Tag.create(name: "Sports")
Tag.create(name: "Henry")
Tag.create(name: "Tech")
Tag.create(name: "Animals")
Tag.create(name: "Christian Kim")
#post_tags
PostTag.create(post_id: yankees.id, tag_id: 1)
PostTag.create(post_id: movie_review.id, tag_id: 2)
PostTag.create(post_id: car_accident.id, tag_id: 3)
PostTag.create(post_id: love_code.id, tag_id: 4)
