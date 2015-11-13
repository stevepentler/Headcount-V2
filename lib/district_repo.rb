require 'csv'
require_relative 'csv_parser'

class DistrictRepository
  
  def initialize
    @districts = []
  end

  def load_csv(csv_paths)
    csv_parser = CSVParser.new(csv_paths)
    @parsed_csv = csv_parser.parsed_csv
  end

  def unique_district?(parsed_csv)
    @districts.each do |district|
      if district[:name] != district_data[:location].upcase
        inistantiate_districts(parsed_csv)
      end
    end
  end

  def instantiate_districts(parsed_csv)
    @districts << District.new(parsed_csv)
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