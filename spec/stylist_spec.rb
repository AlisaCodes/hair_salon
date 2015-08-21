require('rspec')
require('stylist')
require('spec_helper')
require('client')
require("pg")

  DB = PG.connect({:dbname => 'hair_salon_test'})

  RSpec.configure do |config|
    config.after(:each) do
      DB.exec("DELETE FROM stylists *;")
    end
  end

describe(Stylist) do

  describe("#==") do
    it("is the same stylist if it has the same name") do
      stylist1 = Stylist.new({:name => "Steve", :specialty => "Perms", :id => nil})
      stylist2 = Stylist.new({:name => "Steve", :specialty => "Perms", :id => nil})
      expect(stylist1).to(eq(stylist2))
    end
  end

  # before() do
  #   Stylist.clear()
  # end



  describe('#name') do
    it('returns the name of the stylist') do
      stylist = Stylist.new({:name => "Jess", :specialty => "Highlights", :id => nil})
      expect(stylist.name()).to(eq("Jess"))
    end
  end

  describe('#specialty') do
    it('returns the specialty of the stylist') do
      stylist = Stylist.new({:name => "Jess", :specialty => "Highlights", :id => nil})
      expect(stylist.specialty()).to(eq("Highlights"))
    end
  end

  describe('#save') do
    it('saves instance to an array') do
      stylist = Stylist.new({:name => "Jess", :specialty => "Highlights", :id => nil})
      stylist.save()
      expect(Stylist.all()).to(eq([stylist]))
    end
  end

  describe('.all') do
    it('begins empty') do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe("#id") do
    it("displays the id of a stylist after saving") do
      stylist = Stylist.new({:name => "Jess", :specialty => "Highlights", :id => nil})
      stylist.save()
      expect(stylist.id()).to(be_an_instance_of(Fixnum))
    end
  end

  # describe('.find') do
  #   it('returns the stylist by her id number') do
  #     test_stylist = Stylist.new({:name => "Jess", :specialty => "Highlights", :id => 1})
  #     test_stylist.save()
  #     test_stylist2 = Stylist.new({:name => "Brian", :specialty => "Up Do", :id => 2})
  #     expect(Stylist.find(test_stylist.id())).to(eq(test_stylist))
  #   end
  # end

  describe('#list_clients') do
    it('adds a client to the stylists client list') do
      test_stylist = Stylist.new({:name => "Jess", :specialty => "Highlights", :id => nil})
      test_stylist.save()
      test_client = Client.new({:name => "Bettie", :phone_number => "555 555 5555", :stylist_id => test_stylist.id})
      test_client.save()
      expect(test_stylist.list_clients()).to(eq([test_client]))
    end
  end
end
