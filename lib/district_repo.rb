require 'csv'
require_relative 'district'
require_relative 'csv_parser'

class DistrictRepository

  attr_reader :districts, :parsed_csv
  
  def initialize
    @districts = []
    @parsed_csv = nil
  end

  def load_csv(csv_paths)
    csv_parser = CSVParser.new(csv_paths) 
    @parsed_csv = csv_parser.parsed_csv
    @parsed_csv[:enrollment][:kindergarten].each {|parse| unique_district?(parse)}
  end

  def unique_district?(parse)
    empty?(parse)
    @districts.each do |district|
      instantiate_districts(parse) if district.name != parse[:location]
    end
  end

  def empty?(parse)
    if @districts.empty?
      @districts << District.new(parse)
    end
  end

  def instantiate_districts(parse)
    @districts << District.new(parse)
  end 

  def find_by_name(name)
    @districts.find do |district|
      name.upcase == district.name
    end
  end

  def find_all_matching(word_fragment)
    find_all = @districts.select do |district|
      district if district.name.include?(word_fragment.upcase)
    end
    find_all
  end
end 