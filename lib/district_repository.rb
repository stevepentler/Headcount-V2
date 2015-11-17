require 'csv'
require_relative 'district'
require_relative 'csv_parser'
require_relative 'enrollment_repo'

class DistrictRepository

  attr_reader :districts, :parsed_csv, :enrollment_repo

  def initialize
    @districts = []
    @parsed_csv = nil
  end

  def load_data(csv_paths)
    csv_parser = CSVParser.new(csv_paths)
    @parsed_csv = csv_parser.parsed_csv
    @parsed_csv[:enrollment][:kindergarten].each {|parse| unique_district?(parse)} #only using for district names
    @enrollment_repo = EnrollmentRepository.new
    @enrollment_repo.load_data(csv_paths)
    create_data_enroll_link
  end

  def create_data_enroll_link
    @districts.each do |district|
      temp = @enrollment_repo.find_by_name(district.name)
      district.enrollment = temp
    end
  end

  def unique_district?(parse)
    empty?(parse)
    instantiate_districts(parse) if find_by_name(parse[:location])
  end

  def empty?(parse)
    instantiate_districts(parse) if @districts.empty?
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
