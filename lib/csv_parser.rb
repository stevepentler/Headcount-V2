require 'csv'
require 'pry'

class CSVParser

  attr_reader :parsed_csv

  def initialize(csv_paths)
    @csv_paths = csv_paths
    @parsed_csv = {}
    seperate_category
  end

  def seperate_category
    @csv_paths.each do |category, data_type|
      seperate_data_type(data_type)
      @parsed_csv.merge!({category => @sub_category})
    end
  end

  def seperate_data_type(data_type)
    @sub_category = {}
    data_type.each do |sub_category, data_path|
      csv_format = csv_row_format(data_path)
      @sub_category.merge!({sub_category => csv_format})
    end
  end

  def csv_row_format(data_path)
    data_rows = []
    handle = CSV.read(data_path, :headers => true, header_converters: :symbol)
    handle.each do |row|
      row_regulate(row)
      if row[:data].class == Float || row[:data].class == Fixnum
        data_rows << row
      end
    end
    data_rows
  end

  def row_regulate(row)
    row[:location].upcase!
    row[:data] = truncate(row[:data].to_f)
    row[:timeframe] = row[:timeframe].to_i
  end

  def truncate(float)
    (float * 1000).floor / 1000.to_f
  end

end
