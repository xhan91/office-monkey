require 'faker'

User.create!(username: "admin", is_administrator: true)

# generate users
users = []
10.times do |i|
  users[i] = User.create!(
    username: Faker::Name.first_name,
    avatar: Faker::Avatar.image)
end

# generate subjects

subject_names = ["Employee Cafeteria", "Employee Gym", "Work Life Balance", "Office Social Events", "Office Stationary Supplies", "Office Furniture", "Office Temperature", "Office Noise Level", "Office Technology", "Mental Health"]

subjects = []
subject_names.each_with_index do |subject_name, index|
  subjects[index] = Subject.create(name: subject_name)
end

# generate critiques

def content_generator(is_ripe_banana, subject)
  like_works = [", I really like it!", ", that is awesome!", " is so good, why don't we have a party?", ", I like it so much, I will drink a beer for celebration!"]
  dislike_words = ["! I cannot stand for that any more! Show me some change or I will leave!", " is as bad as my grandpa's bicycle!", " is bad bad bad bad (times 100_000).", " is not that bad, but to be honest, it is bad."]
  if is_ripe_banana
    subject.name + like_works.sample
  else
    subject.name + dislike_words.sample
  end
end

users.each do |user|
  (rand(10)+6).times do
    subject = subjects.sample
    is_ripe_banana = (rand(2) == 0)
    content = content_generator(is_ripe_banana, subject)
    created_at = Faker::Time.backward(14)
    critique = Critique.create(
      user: user, 
      subject: subject, 
      is_ripe_banana: is_ripe_banana,
      content: content,
      created_at: created_at)
  end
end

# let users vote
users.each do |user|
  # users vote up for their own critiques
  # users vote others' critiques randomly, 1/2 possibility
  Critique.all.each do |critique|
    if critique.user == user || rand(2) == 0
      Vote.create(user: user, critique: critique)
    end
  end
end



