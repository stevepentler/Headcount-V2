require 'statewide_test_formatter'
require 'pry'

class StatewideRepository

  attr_reader :enrollments

  def initialize
    @statewide_tests = []
    @statewide_tests_formatter = StatewideTestFormatter.new
  end

  def load_data(parsed_csv)
    statewide_testing_csv = parsed_csv[:statewide_testing]
    district_governor(statewide_testing_csv)
  end

  def district_governor(statewide_testing_csv)
    statewide_testing_csv.each do |category, test_rows|
      test_rows.each do |row|
        if @statewide_tests.empty?
          empty?(category, row)
        else
          unique_enrollment?(category, row)
        end
      end
    end
  end

  def unique_test?(category, row)
    state_test = find_by_name(row[:location])
    if state_test == nil
      @statewide_tests << @statewide_test_formatter.district_yearly_data(category, row)
    else
      @statewide_test_formatter.append_district_yearly_data(enrollment, category, row)
    end
  end

  def empty?(category, row)
     @statewide_tests << @statewide_test_formatter.district_yearly_data(category, row)
  end

  def find_by_name(name)
    @statewide_tests.find do |enrollment|
      name.upcase == enrollment.name.upcase
    end
  end

  def find_by_matching
    find_all = @enrollments.select do |enrollment|
      enrollment if enrollment.name.include?(word_fragment.upcase)
    end
    find_all
  end
end
