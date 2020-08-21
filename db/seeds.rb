# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Post.destroy_all
Stop.destroy_all
ActiveStorage::Attachment.all.each(&:purge)
ActionText::RichText.all.each(&:purge)
ActiveStorage::Blob.all.each(&:purge)

Dir.glob("storage/*").each do |dir|
  Dir.glob("#{dir}/*").each do |subdir|
    FileUtils.rmdir(subdir)
  end
  FileUtils.rmdir(dir)
end

images = [
  'chicago.jpeg',
  'denver.jpeg',
  'kc.jpeg',
  'kc.jpeg',
]

chicago = Stop.create!(
  name: "Chicago",
  from: 5.days.ago,
  to: 4.days.ago,
  lat: 41.8781,
  lng: -87.6298,
  slug: "home-sweet-home"
)
chicago.splash.attach(
  io: File.open('db/seeds/chicago.jpeg'),
  filename: 'chicago.jpeg',
  content_type: 'application/jpeg',
  identify: false
)

kc = Stop.create!(
  name: "Kansas City",
  from: 4.days.ago,
  to: 3.days.ago,
  lat: 39.0997,
  lng: -94.5786,
  slug: "kansas-city"
)
kc.splash.attach(
  io: File.open('db/seeds/kc.jpeg'),
  filename: 'kc.jpeg',
  content_type: 'application/jpeg',
  identify: false
)

denver = Stop.create!(
  name: "Denver",
  from: 3.days.ago,
  to: 2.days.ago,
  lat: 39.7392,
  lng: -104.9903,
  slug: "denver"
)
denver.splash.attach(
  io: File.open('db/seeds/denver.jpeg'),
  filename: 'denver.jpeg',
  content_type: 'application/jpeg',
  identify: false
)

sf = Stop.create!(
  name: "San Francisco",
  from: 2.days.ago,
  to: 1.days.ago,
  lat: 37.7749,
  lng: -122.4194,
  slug: "san-francisco"
)
sf.splash.attach(
  io: File.open('db/seeds/sf.jpeg'),
  filename: 'sf.jpeg',
  content_type: 'application/jpeg',
  identify: false
)

[chicago, kc, denver, sf].each do |place|
  2.times do |i|
    post = Post.create!(
      stop: place,
      title: "Here In #{place.name} #{i}",
      slug: "#{place.name.parameterize}-#{i}"
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
