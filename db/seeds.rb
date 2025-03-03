begin
  puts "Seeding users..."

  user_data = [
    { first_name: "First", last_name: "Last", email: "admin@user.com", password: "password", role: "admin" },
    { first_name: "First", last_name: "Last", email: "user1@user.com", password: "password", role: "member" },
    { first_name: "First", last_name: "Last", email: "user2@user.com", password: "password", role: "member" },
    { first_name: "First", last_name: "Last", email: "user3@user.com", password: "password", role: "member" }
  ]

  users = []

  User.transaction do
    user_data.each do |data|
      user = User.create!(data)
      users << user
      puts "User #{user.email} created"
    end
  end
  puts "Users seeded successfully!"

  puts "Seeding pair requests..."

  pair_request_data = [
    { status: "pending", author: users[1], invitee: users[2], when: 1.day.from_now, duration: 30.minutes },
    { status: "pending", author: users[1], invitee: users[3], when: 1.day.from_now, duration: 30.minutes },
    { status: "pending", author: users[2], invitee: users[3], when: 1.day.from_now, duration: 45.minutes },
    { status: "rejected", author: users[1], invitee: users[2], when: 1.day.from_now, duration: 30.minutes },
    { status: "accepted", author: users[1], invitee: users[2], when: 5.day.from_now, duration: 60.minutes },
    { status: "accepted", author: users[2], invitee: users[3], when: Time.now, duration: 60.minutes },
    { status: "accepted", author: users[2], invitee: users[3], when: Time.now, duration: 60.minutes },
    { status: "accepted", author: users[2], invitee: users[3], when: Time.now, duration: 60.minutes },
    { status: "accepted", author: users[3], invitee: users[2], when: Time.now, duration: 60.minutes },
    { status: "accepted", author: users[3], invitee: users[2], when: Time.now, duration: 60.minutes },
    { status: "rejected", author: users[3], invitee: users[1], when: 20.days.from_now, duration: 15.minutes },
  ]

  PairRequest.transaction do
    pair_request_data.each do |data|
      PairRequest.create!(data)
    end
  end
  puts "Pair requests seeded successfully!"

  puts "Seeding completed pair requests with feedback drafts..."
  completed_pair_request_data =[
  { status: "completed", author: users[1], invitee: users[2], when: Time.current - 30.minutes,  duration: 30.minutes },
  { status: "completed", author: users[1], invitee: users[2], when: Time.current - 60.minutes,  duration: 30.minutes },
  { status: "completed", author: users[1], invitee: users[3], when: Time.current - 45.minutes,  duration: 30.minutes },
  { status: "completed", author: users[3], invitee: users[1], when: Time.current - 60.minutes,  duration: 30.minutes },
  { status: "completed", author: users[2], invitee: users[1], when: Time.current - 50.minutes,  duration: 30.minutes },
  ]
  
  PairRequest.transaction do
    completed_pair_request_data.each do |data|
      PairRequest.create!(data).create_draft_feedback!
    end
  end

  puts "Seeding completed pair requests with feedbacks..."


  puts "Seeding a Standup Meeting Group"
  standup_meeting_group = StandupMeetingGroup.create!(
    name: 'PairApp',
    start_time: Time.new(2023,1,1,9,0,0)
  )

  users.each do |user|
    standup_meeting_group.users << user
    7.times do |day_count|
      StandupMeeting.create!(
        meeting_date: (1.week.ago + (day_count + 1).days),
        user:,
        standup_meeting_group:
      )
    end
  end
  puts "Completed seeding standup meeting group!"

rescue StandardError => e
  puts "Error occurred while seeding: #{e.message}"
  puts e.backtrace.join("\n")
end