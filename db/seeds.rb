# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

truman = User.create!(name: "truman", password: Rails.application.credentials.user_password)
carrie = User.create!(name: "carrie", password: Rails.application.credentials.user_password)
users = [truman, carrie]

stop_configs = [
  { name: "Home", lat: 41.8781, lng: -87.6298, image: "chicago.jpeg", from: Date.new(2018, 4, 1), to: Date.new(2020, 10, 8) },
  { name: "Oklahoma City", lat: 35.4676, lng: -97.5164, image: "okc.jpeg", from: Date.new(2020, 10, 8), to: Date.new(2020, 10, 9) },
  { name: "Santa Fe", lat: 35.6870, lng: -105.9378, image: "santa-fe.jpeg", from: Date.new(2020, 10, 9), to: Date.new(2020, 10, 10) },
  { name: "Las Vegas", lat: 36.1699, lng: -115.1398, image: "flagstaff.jpeg", from: Date.new(2020, 10, 10), to: Date.new(2020, 10, 11) },
  { name: "Yosemite", lat: 37.8651, lng: -119.5383, image: "yosemite.jpeg", from: Date.new(2020, 10, 11), to: Date.new(2020, 10, 14) },
  { name: "Sequoia", lat: 36.4864, lng: -118.5658, image: "sequoia.jpeg", from: Date.new(2020, 10, 14), to: Date.new(2020, 10, 16) },
  { name: "Death Valley", lat: 36.5323, lng: -116.9325, image: "death-valley.jpeg", from: Date.new(2020, 10, 16), to: Date.new(2020, 10, 18) },
  { name: "Grand Canyon", lat: 36.0544, lng: -112.1401, image: "grand-canyon.jpeg", from: Date.new(2020, 10, 18), to: Date.new(2020, 10, 22) },
  { name: "Santa Fe", lat: 35.6870, lng: -105.9378, image: "santa-fe.jpeg", from: Date.new(2020, 10, 22), to: Date.new(2020, 10, 23) },
  { name: "Tulsa", lat: 36.1540, lng: -95.9928, image: "tulsa.jpeg", from: Date.new(2020, 10, 23), to: Date.new(2020, 10, 24) },
  { name: "St Louis", lat: 38.6270, lng: -90.1994, image: "st-louis.jpeg", from: Date.new(2020, 10, 24), to: Date.new(2020, 10, 25) },
  { name: "Home Again", lat: 41.8781, lng: -87.6298, image: "chicago.jpeg", from: Date.new(2020, 10, 25), to: Date.new(2021, 3, 31) }
]

offset = ENV.fetch("TRIP_OFFSET") { "0" }.to_i
stops = stop_configs.map.with_index do |stop_config, i|
  stop_config.merge!(
    from: stop_config[:from] - offset.days,
    to: stop_config[:to] - offset.days,
    slug: stop_config[:name].parameterize
  )

  stop = Stop.create!(stop_config.without(:image))
  stop.splash.attach(
    io: File.open("db/seeds/#{stop_config[:image]}"),
    filename: stop_config[:image],
    content_type: 'application/jpeg',
    identify: false
  )

  stop
end

if offset != 0
  stops.each do |stop|
    rand(1..4).times do |i|
      post = Post.create!(
        stop: stop,
        title: "Hey, read this post \##{i} in #{stop.name}",
        description: "Here's a description for stop #{stop.name} post #{i}",
        slug: "#{stop.name.parameterize}-#{i}",
        user: users.sample
      )

      post.update!(content: %{
          <h1>Hi!</h1>
          <blockquote>Quote</blockquote>
          <div>
            <br>
            <strong>Bold<br></strong>
            <em>Italic</em>
          </div>
          <ul>
            <li>one</li><li>two</li><li>three</li>
          </ul>
        }
      )
    end
  end
end
