# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
if User.all.count >= 20
  return
else

  User.all.each do |u|
    if u.profile.nil?
      create_profile!
    elsif u.profile.color.nil?
      u.profile.set_color
    end
  end

  20.times do |n|
    name = Faker::FunnyName.two_word_name

    user = User.create!(username: username = "#{name.parameterize(separator: '_')}#{n}",
                        email: "#{username}#{n}@example.org",
                        password: 'foobar')

    user.create_profile!(full_name: name,
                         location: "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
                         bio: Faker::Quote.famous_last_words,
                         link: 'gemz.onrender.com')
  end

  3.times do
    users = User.all
    users.each do |u|
      post = Faker::Quote.matz
      next if post.length >= 250

      Post.create!(user: u, content: post)
    end
  end

  3.times do
    posts = Post.all.sample(50)
    posts.each do |p|
      comment = Faker::Quotes::Chiquito.joke
      next if comment.length >= 250

      Comment.create!(user: User.all.sample,
                      post: p,
                      content: comment)
    end
  end

  3.times do
    posts = Post.all.sample(50)
    posts.each do |p|
      u = User.all.sample
      next if u.reactions.map(&:reactable).include?(p)

      Reaction.create!(user: u,
                       reactable: p)
    end
  end

  99.times do
    one = User.all.sample
    two = User.all.sample
    return if one == two

    one.add_friend(two)
    two.add_friend(one)
  end
end
