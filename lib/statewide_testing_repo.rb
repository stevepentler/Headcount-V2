require 'statewide_test_formatter'
require 'pry'

class StatewideTestRepository

  attr_reader :statewide_tests

  def initialize
    @statewide_tests =  []
    @statewide_test_formatter = StatewideTestFormatter.new
  end

  def load_data(parsed_csv)
    statewide_testing_csv = parsed_csv[:statewide_testing]
    district_governor(statewide_testing_csv)
  end

  def district_governor(statewide_testing_csv)
    statewide_testing_csv.each do |category, test_rows|
      test_rows.each do |row|
        unique_test?(category, row)
      end
    end
  end

  def unique_test?(category, row)
    if category == :third_grade
      category = 3
    elsif category == :eigth_grade
      category = 8
    end
    state_test = find_by_name(row[:location])
    if state_test == nil || @statewide_tests.empty?
      @statewide_tests << @statewide_test_formatter.district_yearly_data(category, row)
    else
      @statewide_test_formatter.append_district_yearly_data(state_test, category, row)
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
