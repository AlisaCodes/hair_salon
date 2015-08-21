class Client
  attr_reader(:name, :phone_number, :stylist_id)

  @@clients = []
  clients = []

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @phone_number = attributes.fetch(:phone_number)
    @stylist_id = attributes.fetch(:stylist_id)
    @clients = []
  end



  define_method(:==) do |another_client|
    self.name().==(another_client.name()).&(self.stylist_id().==(another_client.stylist_id()))
  end

  define_method(:clients) do
    @clients
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (name, phone_number, stylist_id) VALUES ('#{@name}', '#{@phone_number}', #{@stylist_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end



  define_singleton_method(:clear) do
    @@clients.clear()
  end

  define_singleton_method(:all) do
    # @@clients
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each() do |client|
      name = client.fetch("name")
      phone_number = client.fetch("phone_number")
      stylist_id = client.fetch("stylist_id").to_i()

      clients.push(Client.new({:name => name, :phone_number => phone_number, :stylist_id => stylist_id}))
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
end
