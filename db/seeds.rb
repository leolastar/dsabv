# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(name:                    "Admin",
             email:                   "admin@example.com",
             password:                "adminaccount",
             password_confirmation:   "adminaccount",
             address:                 "1200 Main Street, Bryan, TX",
             phone:                   "(979) 000-0000",
             emergency_contact_name:  "Boss",
             emergency_contact_phone: "(979) 999-9999",
             admin:                   true,
             activated:               true,
             activated_at:            "01-01-2000"
)

User.create!(name:                    "Sam White",
             email:                   "samhwhite@gmail.com",
             password:                "password",
             password_confirmation:   "password",
             address:                 "Bryan, TX",
             phone:                   "(979) 000-0000",
             emergency_contact_name:  "Example",
             emergency_contact_phone: "(979) 999-9999",
             admin:                   true,
             activated:               true,
             activated_at:            "01-01-2000"
)

99.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.safe_email
  password = "password"
  address = Faker::Address.street_address + ", " +
            Faker::Address.city + ", " +
            Faker::Address.state_abbr
  phone = Faker::PhoneNumber.cell_phone
  emergency_contact_name = Faker::Name.name
  emergency_contact_phone = Faker::PhoneNumber.cell_phone
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               address: address,
               phone:   phone,
               emergency_contact_name:  emergency_contact_name,
               emergency_contact_phone: emergency_contact_phone,
               activated:    true,
               activated_at: Time.zone.now
  )
end


sample_events = [

  { title:       "Casa Ole Profit Share",
    place:       "Various Casa Ole Locations in BCS and Brenham",
    date:        "06-05-2015",
    description: "Please bring flier (to be attached) to your local Casa Ole and attach to your ticket. A percentage of proceeds will be donated to DSABV." },

  { title:       "Shrek the Musical: Advanced Cooking",
    place:       "DSABV office, Bryan, TX",
    date:        "20-06-2015",
    description: "Shrek the Musical is for our advanced cooking class members. The purpose of this event is to enhance public etiquette skills." },

  { title:       "Family Funfest",
    place:       "1802 Wilde Oak Cir, Bryan, TX",
    date:        "12-08-2015",
    description: "Fun for kids of all ages and great resources for parents! The DSABV will be advertising at the event." },

  { title:       "DSABV Summer Pool Party",
    place:       "Henderson Harbor Pool, 1629 Mockingbird Rd, Bryan, TX",
    date:        "19-08-2015",
    description: "Come out and join the fun as we celebrate the end of summer together!" },

  { title:       "Buddy Walk",
    place:       "Wolf Pen Creek Amphitheater, College Station, TX",
    date:        "15-10-2015",
    description: "The Buddy Walk was established in 1995 by the National Down Syndrome Society to celebrate Down Syndrome Awareness Month in October and to promote acceptance and inclusion of people with Down syndrome." }

]


sample_time_slots = [

  { total_capacity:      10,
    remaining_capacity:  10,
    start_time:          "08:00",
    end_time:            "10:00" },

  { total_capacity:      15,
    remaining_capacity:  15,
    start_time:          "10:00",
    end_time:            "12:00" },

  { total_capacity:      10,
    remaining_capacity:  10,
    start_time:          "12:00",
    end_time:            "14:00" }

]


sample_events.each do |event|
  Event.create!(event)
  sample_time_slots.each do |time_slot|
    # date = Event.last.date.to_date.to_s
    date = Event.last.date.to_s
    time_slot[:start_time] = date + " " + time_slot[:start_time]
    time_slot[:end_time]   = date + " " + time_slot[:end_time]
    Event.last.time_slots.create!(time_slot)
  end
end
