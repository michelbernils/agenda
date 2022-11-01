# frozen_string_literal: true

require 'csv'

# This class contains all the logic necessary for CSV Class
class Csv
  attr_accessor :file

  def initialize(file:)
    @file = file
  end

  def start
    directory_path = '../agendas'
    Dir.mkdir(directory_path) unless Dir.exist?(directory_path)
    CSV.open(file, 'a+') do |csv|
      csv << %w[id category name email] if csv.count.eql? 0
    end
  end

  def add(category, name, email)
    id = CSV.read(file).count
    csv << [id, category, name, email]
    csv.flush
  end

  def update(id, category, name, email)
    CSV.open('new_data.csv', 'w+', write_headers: true, headers: %w[id category name email]) do |new_csv|
      CSV.foreach(file, headers: true, header_converters: :symbol, converters: :all) do |row|
        if row[:id] == id.to_i
          p 'chegou aqui'
          row[:category] = category
          row[:name] = name
          row[:email] = email
        end
        new_csv << row
      end
    end
    File.delete(file)
    File.rename("new_data.csv", file)
  end

  def search(id)
    csv_parsed = CSV.parse(File.read(file), headers: true)
    if csv_parsed.find { |row| row['id'] == id  }
      puts 'User found'
    else
      puts 'User not found'
    end
  end

  def delete(id)    
    table = CSV.table(file)
    table.delete_if do |row|
      row[:id] == id.to_i
    end
    File.open(file, 'w') do |f|
      f.write(table.to_csv)
    end
  end

  private

  def csv
    @csv ||= CSV.open(file, 'a+')
  end
end
