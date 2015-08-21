require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/client")
require("./lib/stylist")
require("pg")

DB = PG.connect({:dbname => "hair_salon_test"})

get('/') do
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:index)
end

post('/') do

  if params.fetch('name', :nil => nil).is_a?(String)
    name = params.fetch('name')
    specialty = params.fetch('specialty')
    stylist = Stylist.new({:name => name, :specialty => specialty, :id => nil})
    stylist.save()
  elsif params.fetch('client_name', :nil => nil).is_a?(String)
    client_name = params.fetch('client_name')
    phone_number = params.fetch('phone_number')
    client = Client.new({:client_name => client_name, :phone_number => phone_number, :stylist_id => nil})
    client.save()
  end
    @stylists = Stylist.all()
    @clients = Client.all()
    erb(:index)
  end

  post('/') do
    name = params.fetch("name")
    specialty = params.fetch("specialty")
    @stylist = Stylist.find(params.fetch("id").to_i())
    @stylist.update({:name => name, specialty => specialty})
    erb(:index)
  end

  delete("/") do
    @vehicle = Vehicle.find(params.fetch("id").to_i())
    @vehicle.delete()
    @vehicle = Vehicle.all()
    erb(:index)

  end
