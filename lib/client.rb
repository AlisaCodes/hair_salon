class Client
  attr_reader(:client_name, :phone_number, :stylist_id)
# go in and add client ID to all attributes/hashes of attributes
  @@clients = []
  clients = []

  define_method(:initialize) do |attributes|
    @client_name = attributes.fetch(:client_name)
    @phone_number = attributes.fetch(:phone_number)
    @stylist_id = attributes.fetch(:stylist_id)
    @clients = []
  end



  define_method(:==) do |another_client|
    self.client_name().==(another_client.client_name()).&(self.stylist_id().==(another_client.stylist_id()))
  end

  define_method(:clients) do
    @clients
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (client_name, phone_number, stylist_id) VALUES ('#{@client_name}', '#{@phone_number}', #{@stylist_id});")
    # @id = result.first().fetch('id').to_i()
  end



  define_singleton_method(:clear) do
    @@clients.clear()
  end

  define_singleton_method(:all) do
    # @@clients
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each() do |client|
      client_name = client.fetch("client_name")
      phone_number = client.fetch("phone_number")
      stylist_id = client.fetch("stylist_id").to_i()

      clients.push(Client.new({:client_name => client_name, :phone_number => phone_number, :stylist_id => stylist_id}))
    end
    clients
  end


  define_singleton_method(:find) do |stylist_id|
    found_client = nil
    @@clients.each() do |client|
      if stylist.id == stylist_id
        found_client = client
      end
    end
    found_client
  end

  define_method(:update) do |attributes|
    @client_name = attributes.fetch(:client_name)
    @phone_number = attributes.fetch(:phone_number)
    @stylist_id = self.stylist_id()
    DB.exec("UPDATE stylists SET client_name, specialty = '#{@client_name}', '#{@specialty}' WHERE stylist_id = #{@stylist_id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM clients WHERE id = #{self.id()};")
    DB.exec("DELETE FROM stylists WHERE list_id = #{self.id()};")
  end
end
