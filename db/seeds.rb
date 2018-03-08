# This file should contain all the record creation needed to seed
# the database with its default values.
# The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# user = CreateAdminService.new.call
# puts 'CREATED ADMIN USER: ' << user.email

require 'faker'
include Faker


[:keppler_admin, :admin, :client, :author, :editor].each do |name|
  Role.create name: name
  puts "Role #{name} has been created"
end

User.create(
  name: 'Keppler Admin', email: 'admin@keppler.com', password: '12345678',
  password_confirmation: '12345678', role_ids: '1'
)

puts 'admin@keppler.com has been created'

Customize.create(file: "", installed: true)
puts 'Keppler Template has been created'
# Create setting deafult
setting = Setting.create(
  name: 'Keppler Admin', description: 'Welcome to Keppler Admin',
  smtp_setting_attributes: {
    server_address: 'test', port: '25', domain_name: 'keppler.com',
    email: 'info@keppler.com', password: '12345678'
  },
  google_analytics_setting_attributes: {
    ga_account_id: '60688852',
    ga_tracking_id: 'UA-60688852-1',
    ga_status: true
  }
)
setting.social_account = SocialAccount.new
setting.appearance = Appearance.new(theme_name: 'keppler')
setting.save
puts 'Setting default has been created'

# 15.times do |x|
#   Destination.create(
#     :name      => Faker::GameOfThrones.city,
#     :subtitle  => Faker::HarryPotter.quote,
#     # :banner    => '/assets/img/destino.jpg',
#   )
# end
#
# puts 'Destinos creados'
#
# 100.times do |x|
#   Hotel.create(
#     # :banner          => '/assets/img/hotel.jpg',
#     :title           => Faker::Fallout.location,
#     :days            => Faker::Number.number(2),
#     :url             => Faker::Internet.url,
#     :destination_id  => Faker::Number.between(1, 15),
#     :price           => {"cop" =>  Faker::Number.decimal(2), "usd" => Faker::Number.decimal(2)}
#   )
# end
# puts 'Hoteles creados'
#
# 100.times do |x|
#   Plan.create(
#     # :banner          => '/assets/img/plan.jpg',
#     :title           => Faker::Fallout.location,
#     :days            => Faker::Number.number(2),
#     :url             => Faker::Internet.url,
#     :destination_id  => Faker::Number.between(1, 15),
#     :price           => {"cop" =>  Faker::Number.decimal(2), "usd" => Faker::Number.decimal(2)}
#   )
# end
# puts 'Planes creados'
#
# 100.times do |x|
#   Excursion.create(
#     # :banner          => '/assets/img/excursion.jpg',
#     :title           => Faker::Fallout.location,
#     :days            => Faker::Number.number(2),
#     :url             => Faker::Internet.url,
#     :destination_id  => Faker::Number.between(1, 15),
#     :type_activity   => Faker::Space.galaxy,
#     :price           => {"cop" =>  Faker::Number.decimal(2), "usd" => Faker::Number.decimal(2)}
#   )
# end
# puts 'Actividades creados'

# KepplerContactUs::MessageSetting.create(mailer_from: '', mailer_to: '')
