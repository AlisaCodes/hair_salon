class Stylist
  attr_reader(:name, :specialty, :id)

  @@stylists = []
  stylists = []

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @specialty = attributes.fetch(:specialty)
    @id = attributes.fetch(:id, nil)
  end

  define_method(:save) do
    # @@stylists.push(self)

    result = DB.exec("INSERT INTO stylists (name, specialty) VALUES ('#{@name}', '#{@specialty}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  # define_singleton_method(:clear) do
  #   @@stylists.clear()
  # end

  define_singleton_method(:all) do
    # @@stylists
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    stylists = []
    returned_stylists.each() do |stylist|
      name = stylist.fetch("name")
      specialty = stylist.fetch("specialty")
      id = stylist.fetch("id").to_i()
      stylists.push(Stylist.new({:name => name, :specialty => specialty, :id => id}))
    end
    stylists
  end
  define_method(:==) do |another_stylist|
    self.name().==(another_stylist.name())
  end

  define_method(:list_clients)  do
    @id = self.id()
    all_clients = []
    clients = DB.exec("Select * FROM clients WHERE stylist_id=#{@id};")
    clients.each do |client|
      name = client.fetch('name')
      phone_number = client.fetch('phone_number')
      stylist_id = client.fetch('stylist_id').to_i()
      all_clients.push(Client.new({:name => name, :phone_number => phone_number, :stylist_id => stylist_id}))
    end
    all_clients
  end

  define_singleton_method(:find) do |id|
    found_stylist = nil
    Stylist.each() do |stylist|
      if stylist.id() .== (id)
        found_stylist = stylist
      end
    end
    found_client
  end

  define_method(:clients) do
   list_clients = []
   clients = DB.exec("SELECT * FROM clients WHERE stylist_id = #{self.id()};")
   clients.each() do |client|
     name = client.fetch("name")
     phone_number = client.fetch("phone_number")
     stylist_id = client.fetch("stylist_id").to_i()
     list_clients.push(Client.new({:name => name, :stylist_id => stylist_id}))
   end
   list_clients
 end

 define_method(:update) do |attributes|
   @name = attributes.fetch(:name)
   @specialty = attributes.fetch(:specialty)
   @id = self.id()
   DB.exec("UPDATE stylists SET name, specialty = '#{@name}', '#{@specialty}' WHERE id = #{@id};")
 end

 define_method(:delete) do
   DB.exec("DELETE FROM clients WHERE id = #{self.id()};")
   DB.exec("DELETE FROM stylists WHERE list_id = #{self.id()};")
 end
end
