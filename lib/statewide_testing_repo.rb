require_relative 'statewide_test_formatter'
require_relative 'csv_parser'
require 'pry'

class StatewideTestRepository

  attr_reader :statewide_tests

  def initialize
    @statewide_tests = []
    @statewide_test_formatter = StatewideTestFormatter.new
  end

  def load_data(parsed_csv)
    if parsed_csv.has_key?(:statewide_testing)
      csv_parser = CSVParser.new(parsed_csv)
      parsed_csv = csv_parser.parsed_csv
      @statewide_test_formatter.district_governor(parsed_csv)
      create_statewide_testing_objects
    end
  end

  def create_statewide_testing_objects
    @statewide_test_formatter.statewide_tests_hash.each do |test|
      @statewide_tests << StatewideTest.new(test)
    end
  end

  def find_by_name(name)
    @statewide_tests.find do |statewide_test|
      name.upcase == statewide_test.name.upcase
    end
  end

  def find_by_matching
    find_all = @statewide_tests.select do |statewide_test|
      statewide_test if statewide_test.name.include?(word_fragment.upcase)
    end
    find_all
  end
end
