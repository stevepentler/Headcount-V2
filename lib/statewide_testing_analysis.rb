require_relative 'district_repository'
require_relative 'statewide_test'
class StatewideTestingAnalysis

  def initialize(district_repo)
    @district_repo = district_repo
    @statewide_tests = @district_repo.statewide_test_repo.statewide_tests
  end 

  def top_statewide_test_year_over_year_growth(testing_categories)
    input_error?(testing_categories)
    all_district_growths = district_subject_growths(testing_categories)
    top_districts(testing_categories, all_district_growths)
  end
  #   if testing_categories.has_key?(:subject)
  #     top = nil
  #     if testing_categories.has_key?(:top)
  #       top = testing_categories[:top]
  #     end
  #     (district_subject_growths(testing_categories).max(top) {|pair| pair[1]})
  #   else
  #     change = @statewide_tests.map do |state_test|
  #       if state_test.name != "COLORADO"
  #        district_growths_across_subjects(testing_categories, state_test)
  #       end
  #     end
  #   end 
  # end 

  def top_districts(testing_categories, all_district_growths)
    top = nil
    if testing_categories.has_key?(:top)
      top = testing_categories[:top]
    end
    (all_district_growths.max(top) {|pair| pair[1]})
  end 

  def district_subject_growths(testing_categories)
    change = @statewide_tests.map do |state_test|
      if state_test.name != "COLORADO"
        [state_test.name, route_by_subject(testing_categories, state_test)]
      end
    end 
    change.compact
  end

  def route_by_subject(testing_categories, state_test)
    if testing_categories.has_key?(:subject)
      find_growth_for_subjects(testing_categories, state_test)
    else
      district_growths_across_subjects(testing_categories, state_test)
    end 
  end 

  def district_growths_across_subjects(testing_categories, state_test)
    subjects = [:math, :writing, :reading]
    values = subjects.map do |single_subject|
      testing_categories[:subject] = single_subject
      {single_subject => (find_growth_for_subjects(testing_categories, state_test))}
    end
    values
    # (values.compact.inject(:+) / 3)
  end

  def find_growth_for_subjects(testing_categories, state_test)
    array = state_test.proficient_by_grade(testing_categories[:grade]).to_a
    first = array[0][1][testing_categories[:subject]]
    last = array[-1][1][testing_categories[:subject]]
    truncate((last - first)/(array[-1][0] - array[0][0]))
  end

  def even_weighting
    {math: 1.0/3, reading: 1.0/3, writing: 1.0/3}
  end 

  def truncate(float)
    (float * 1000).floor / 1000.to_f
  end
 
  def input_error?(testing_categories)
    unless testing_categories.keys.include?(:grade)
      raise InsufficientInformationError,
        "A grade must be provided to answer this question"
    end 
    unless testing_categories[:grade] == 3 || testing_categories[:grade] == 8
      raise UnknownDataError,
      "#{testing_categories[:grade]} is not a known grade."
    end 
  end 
end