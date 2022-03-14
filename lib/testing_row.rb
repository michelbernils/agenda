require_relative '../lib/contacts'
require_relative '../lib/agenda'
require 'csv'


table = CSV.parse(File.read("../files/contacts.csv"), headers: true)
contact = Contacts.new(name: 'michel', email: 'bernils.michel@gmail.com')

puts table.first.to_h
puts ["nome"=> contact.name, "email"=> contact.email].to_s
