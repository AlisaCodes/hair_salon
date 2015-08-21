require('rspec')
require('stylist')
require('spec_helper')
require('client')
require("pg")

DB = PG.connect({:dbname => 'hair_salon_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM clients *;")
  end
end

describe(Client) do
  # before() do
  #   Client.clear()
  # end

  describe("#==") do
    it("is the same client if it has the same client_name and attribute info") do
      test_client1 = Client.new({:client_name => "Buzz", :phone_number => "555 555 555", :stylist_id => 1, :id => 1})
      test_client2 = Client.new({:client_name => "Buzz", :phone_number => "555 555 555", :stylist_id => 1, :id => 1})
      expect(test_client1).to(eq(test_client2))
    end
  end

  describe('#client_name') do
    it('returns the client_name of the test_client') do
      test_client = Client.new({:client_name => "Buzz", :phone_number => "555 555 555", :stylist_id => 1, :id => 1})
      expect(test_client.client_name()).to(eq("Buzz"))
    end
  end

  describe('#phone_number') do
    it('returns the specialty of the test_client') do
      test_client = Client.new({:client_name => "Buzz", :phone_number => "555 555 555", :stylist_id => 1, :id => 1})
      expect(test_client.phone_number()).to(eq("555 555 555"))
    end
  end

  describe('#stylist_id') do
    it("let you read the stylist ID out") do
      test_client = Client.new({:client_name => "Buzz", :phone_number => "555 555 555", :stylist_id => 1,  :id => 1})
      expect(test_client.stylist_id()).to(eq(1))
    end
  end

  describe("#id") do
    it("displays the id of a test_client after saving") do
      test_client = Client.new({:client_name => "Buzz", :phone_number => "555 555 555", :stylist_id => 1, :id => 1})
      test_client.save()
      expect(test_client.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#save') do
    it('saves instance to an array') do
      test_client = Client.new({:client_name => "Buzz", :phone_number => "555 555 5555", :stylist_id => 1,  :id => nil})
      test_client.save()
      expect(Client.all()).to(eq([test_client]))
    end
  end

  # describe('.find') do
  #   it('returns the stylist by her id number') do
  #     test_stylist = Stylist.new({:client_name => "Jess", :specialty => "Highlights", :id => 1})
  #     test_stylist.save()
  #     test_stylist2 = Stylist.new({:name => "Brian", :specialty => "Up Do", :id => 2})
  #     expect(Stylist.find(test_stylist.id())).to(eq(test_stylist))
  #   end
  # end

  describe('.all') do
    it('begins empty') do
      expect(Client.all()).to(eq([]))
    end
  end
end
