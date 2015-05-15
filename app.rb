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

patch "/bands/:band_id/venues" do |band_id|
  venue_ids = params.keys.select { |key| key.to_i != 0 }
  new_venues = venue_ids.map { |venue_id| Venue.find(venue_id) }
  band = Band.find(band_id)
  band.venues << new_venues
  redirect "/bands/#{band_id}"
end

post "/venues/new" do
  name = params["venue_name"]
  location = params["location"]
  Venue.create(name: name, location: location)
  redirect "/"
end
