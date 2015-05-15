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

post "/venues/new" do
  name = params["venue_name"]
  location = params["location"]
  Venue.create(name: name, location: location)
  redirect "/"
end
