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
      csv << %w[category name email] if csv.count.eql? 0
    end
  end

  def add(*row)
    csv << row

    csv.flush
  end

  def search(name)
    csv_parsed = CSV.parse(File.read(file), headers: true)
    if csv_parsed.find { |row| row['name'] == name }
      puts 'Usuario encontrado'
    else
      puts 'User not found'
    end
  end

  def delete(name)
    table = CSV.table(file)
    table.delete_if do |row|
      row[:name] == name
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
