require_relative '../../lib/entity/contact'
require 'csv'
load('../lib/agenda.thor')

Class ContactRepository

  def start_agenda(file_name)
    agenda = Agenda.new(file_name: file_name)
    file_path = "../files/#{agenda.file_name}"
    headers = ['name','email']
    CSV.open(file_path, 'a+') do |csv|
      csv << headers if csv.count.eql? 0 
      end
    end
  end

  def file_exists?(file_name)
    if(File.exist?("../files/#{file_name}")) 
      true
    else 
      false
    end
  end

  def add_contact_to_csv(file_name, name, email)
    return unless File.exist?("../files/#{file_name}")
    CSV.open("../files/#{file_name}", "a+") do |csv|
      csv << [contact.name, contact.email]
      end
    end
  end

  def search_contact_on_csv_using_name(file_name, name)
    return unless File.exist?("../files/#{file_name}")
    csv = CSV.parse(File.read("../files/#{file_name}"), headers: true)
      if (csv.find {|row| row["name"] == contact.name})
        puts "Usuario encontrado"
        puts contact.name
      else
        puts "User not found"
      end
    end
  end

  def delete_contact_on_csv_using_name(file_name, name)
    return unless File.exist?("../files/#{file_name}")
    table = CSV.table(("../files/#{file_name}")
      table.delete_if do |row|
        row[:name] == contact.name
      end
    
      File.open("../files/#{file_name}", 'w') do |f|
        f.write(table.to_csv)
      end
    end
  end
  
end

