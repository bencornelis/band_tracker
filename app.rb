require('bundler/setup')
Bundler.require(:default, :production)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file}

get "/" do
  @bands = Band.all
  @venues = Venue.all
  erb :index
end

get "/bands/:id" do |id|
  @band = Band.find(id)
  erb :band
end

post "/bands/new" do
  name = params["band_name"]
  origin = params["origin"]
  year_founded = params["year_founded"]
  Band.create(name: name, origin: origin, year_founded: year_founded)
  redirect "/"
end

delete "/bands/:id" do |id|
  Band.destroy(id)
  redirect "/"
end

patch "/bands/:id" do |id|
  new_name = params["new_name"]
  Band.find(id).update(name: new_name)
  redirect "/bands/#{id}"
end

post "/bands/:id/edit/name" do |id|
  @edit_name = true
  @band = Band.find(id)
  erb :band
end

post "/bands/:id/edit/genres" do |id|
  @edit_genre = true
  @band = Band.find(id)
  erb :band
end

patch "/bands/:id/genres" do |id|
  band = Band.find(id)
  genre_name = params["genre_name"]
  band.genres.create(name: genre_name)
  redirect "/bands/#{id}"
end

patch "/bands/:band_id/venues" do |band_id|
  venue_ids = params.keys.select { |key| key.to_i != 0 }
  new_venues = venue_ids.map { |venue_id| Venue.find(venue_id) }
  band = Band.find(band_id)
  band.venues << new_venues
  redirect "/bands/#{band_id}"
end

get "/venues/:id" do |id|
  @venue = Venue.find(id)
  erb :venue
end

delete "/venues/:id" do |id|
  Venue.destroy(id)
  redirect "/"
end

patch "/venues/:venue_id/bands" do |venue_id|
  band_ids = params.keys.select { |key| key.to_i != 0 }
  new_bands = band_ids.map { |band_id| Band.find(band_id) }
  venue = Venue.find(venue_id)
  venue.bands << new_bands
  redirect "/venues/#{venue_id}"
end

post "/venues/new" do
  name = params["venue_name"]
  location = params["location"]
  Venue.create(name: name, location: location)
  redirect "/"
end

patch "/venues/:id" do |id|
  new_name = params["new_name"]
  Venue.find(id).update(name: new_name)
  redirect "/venues/#{id}"
end

post "/venues/:id/edit" do |id|
  @edit = true
  @venue = Venue.find(id)
  erb :venue
end
