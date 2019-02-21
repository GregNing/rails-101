namespace :dev do
  desc 'Rebuild system'
  task build: %w[tmp:clear log:clear db:drop db:create db:migrate]
  task rebuild: %w[dev:build db:seed]

  desc 'Fake System Data'
  task fake_data: :environment do
    require 'faker'
    require 'populator'
    require 'bcrypt'

    User.populate(5) do |user|
      user.email = Faker::Internet.email
      user.name = Faker::WorldOfWarcraft.hero
      user.encrypted_password = BCrypt::Password.create('password')
      puts "User Name: #{user.name}"

      Group.populate(1..2) do |group|
        group.user_id = user.id
        group.title = Populator.words(1..3).titleize
        puts "Group Title: #{group.title}"
        group.description = Faker::WorldOfWarcraft.quote
        puts "Group Description: #{group.description}"
        group.created_at = 5.days.ago..Time.now
        GroupUser.create(user_id: user.id, group_id: group.id)
        posts_count = 1

        Post.populate(1..2) do |post|
          group.posts_count = posts_count
          post.user_id = user.id
          post.group_id = group.id
          post.content = Populator.sentences(1)
          puts "Post content: #{post.content}"
          post.created_at = 2.hours.ago..Time.now
          posts_count = 1

          Message.populate(1..2) do |message|
            message.user_id = user.id
            message.post_id = post.id
            message.content = Faker::WorldOfWarcraft.quote
            post.created_at = 1.hours.ago..Time.now
          end
        end
      end
    end
  end
end
