require 'random_data'


# Create Users
5.times do
  User.create!(
# #3
  name:     RandomData.random_name,
  email:    RandomData.random_email,
  password: RandomData.random_sentence
  )
end
users = User.all
# Create Topics
15.times do
  Topic.create!(
    name:        RandomData.random_sentence,
    description: RandomData.random_paragraph
  )
end
topics = Topic.all

# Create Posts
50.times do
   post = Post.create!(
    user:   users.sample,
    topic: topics.sample,
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
  )

# #12
  post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
# #13
  rand(1..5).times { post.votes.create!(value: [-1, 1].sample, user: users.sample) }
end
posts = Post.all

# Create Sponsored Posts
10.times do
  SponsoredPost.create!(
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    price: RandomData.random_number
  )
end
sponsored_posts = SponsoredPost.all

# Create Comments
100.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

#DB failed to reset with the following post/comment included - Couldn't find post 51.
#Post.find_or_create_by( title: "The Last of Us 2",
  #body: "Prepare for the biggest game of 2018 with The Last of Us 2!")

#Comment.find_or_create_by( post: Post.find(51), body: 'First Comment about the Last of Us 2!')

# Create Questions
100.times do
	Question.create!(
		title: RandomData.random_sentence,
		body: RandomData.random_paragraph,
		resolved: false
	)
end

# Create an admin user
admin = User.create!(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)

# Create a member
member = User.create!(
  name:     'Member User',
  email:    'member@example.com',
  password: 'helloworld'
)




 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Topic.count} topics created"
 puts "#{Post.count} posts created"
 puts "#{SponsoredPost.count} sponsored posts created"
 puts "#{Comment.count} comments created"
  puts "#{Vote.count} votes created"
 puts "#{Question.count} questions created"
