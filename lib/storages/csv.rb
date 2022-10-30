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
    csv_parsed = CSV.parse(File.read(file), headers: true)
    if csv_parsed.find { |row| row['id'] == id  }
      csv << [category, name, email]
    else
      p 'User not found'
    end
  end

  def search(id)
    csv_parsed = CSV.parse(File.read(file), headers: true)
    if csv_parsed.find { |row| row['id'] == id  }
      puts 'User not found'
    else
      puts 'User not found'
    end
  end

  def delete(id)    
    table = CSV.table(file)
    table.delete_if do |row|
      row[:id] == id
      p 'User deleted'
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
