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
  stylist = Stylist.new({:name => name, :specialty => specialty, :id => nil})
  stylist.save()
  @stylists = Stylist.all()

  client = Client.new({:client_name => client_name, :phone_number => phone_number, :stylist_id => nil})
  client.save()

  if params.fetch('name', 'specialty', :nil => nil).is_a?(string)
    name = params.fetch('name')
    specialty = params.fetch('specialty')
  elsif params.fetch('client_name', 'phone_number', :nil => nil).is_a?(string)
    client_name = params.fetch('client_name')
    phone_number = params.fetch('phone_number')
  end
end
