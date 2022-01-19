require 'csv'
file = "my_file.csv"

class MyCLI < Thor
  desc "add_contact", "add contact to our csv file"

  def add_contact(name)

    CSV.open( file, 'w' ) do |writer|
      @coun.each do |c|
        writer << [c.name, c.country_code, c.user_id, c.subscriber_id]
      end
    end
    
  end

  def hello(name)
    puts "Hello #{name}"
  end


end