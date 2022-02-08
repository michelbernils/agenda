require 'fileutils'

class MyCLI < Thor
  desc "add NAME", "add contacts to our csv file"
  def add(name)
    File.open("../files/contacts.txt", "a"){
      |f| f.write "#{name}\n"
    }
  end

  desc "read FILE", "load contacts from our contact.csv"
  def list()
    puts File.read("../files/contacts.csv")
  end

  desc "delete NAME", "delete contacts from our contact.csv"
  def delete(name)

    open('../files/contacts.txt', 'r') do |f|
      open('../files/contacts_tmp.txt', 'w') do |f2|
        f.each_line do |line|
           f2.write(line) unless line.start_with? "#{name}\n"
        end
      end
    end

    FileUtils.mv '../files/contacts_tmp.txt', '../files/contacts.txt'

  end

end