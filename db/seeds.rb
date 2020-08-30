# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

stop_configs = [
  { name: "Chicago Start", lat: 41.8781, lng: -87.6298, image: "chicago.jpeg" },
  { name: "Oklahoma City", lat: 35.4676, lng: -97.5164, image: "okc.jpeg" },
  { name: "Santa Fe", lat: 35.6870, lng: -105.9378, image: "santa-fe.jpeg" },
  { name: "Las Vegas", lat: 36.1699, lng: -115.1398, image: "flagstaff.jpeg" },
  { name: "Yosemite", lat: 37.8651, lng: -119.5383, image: "yosemite.jpeg" },
  { name: "Sequoia", lat: 36.4864, lng: -118.5658, image: "sequoia.jpeg" },
  { name: "Death Valley", lat: 36.5323, lng: -116.9325, image: "death-valley.jpeg" },
  { name: "Grand Canyon", lat: 36.0544, lng: -112.1401, image: "grand-canyon.jpeg" },
  { name: "Santa Fe", lat: 35.6870, lng: -105.9378, image: "santa-fe.jpeg" },
  { name: "Tulsa", lat: 36.1540, lng: -95.9928, image: "tulsa.jpeg" },
  { name: "St Louis", lat: 38.6270, lng: -90.1994, image: "st-louis.jpeg" },
  { name: "Chicago End", lat: 41.8781, lng: -87.6298, image: "chicago.jpeg" },
]

stops = stop_configs.map.with_index do |stop_config, i|
  stop_config.merge!(
    from: (3 - i).days.ago,
    to: (2 - i).days.ago,
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

stops.each do |stop|
  rand(1..4).times do |i|
    post = Post.create!(
      stop: stop,
      title: "Post \##{i} in #{stop.name}",
      description: "Here's a description for stop #{stop.name} post #{i}",
      slug: "#{stop.name.parameterize}-#{i}"
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
