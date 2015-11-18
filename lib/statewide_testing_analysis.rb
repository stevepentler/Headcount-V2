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

  def district_subject_growths(testing_categories)
    change = @statewide_tests.map do |state_test|
      if state_test.name != "COLORADO"
        [state_test.name, route_by_subject(testing_categories, state_test)]
      end
    end 
    change.compact
  end

  def route_by_subject(testing_categories, state_test)
    testing_categories.has_key?(:subject) ?
      (find_growth_for_subjects(testing_categories, state_test)) :
      (district_growths_across_subjects(testing_categories, state_test)) 
  end 

  def top_districts(testing_categories, all_district_growths)
    top = nil
    if testing_categories.has_key?(:top)
      top = testing_categories[:top]
    end
    (all_district_growths.max(top) {|pair| pair[1]})
  end 

  def district_growths_across_subjects(testing_categories, state_test)
    subjects = [:math, :writing, :reading]
    values = subjects.map do |single_subject|
      testing_categories[:subject] = single_subject
      find_growth_for_subjects(testing_categories, state_test)
    end
    truncate(values.compact.inject(:+) / 3)
  end

  def find_growth_for_subjects(testing_categories, state_test)
    array = state_test.proficient_by_grade(testing_categories[:grade]).to_a
    first = array[0][1][testing_categories[:subject]]
    last = array[-1][1][testing_categories[:subject]]
    difference = ((last - first) * even_weighting(testing_categories))
    truncate((difference)/(array[-1][0] - array[0][0]))
  end

  def even_weighting(testing_categories)
    (testing_categories.has_key?(:weighting)) ?
    ((testing_categories[:weighting][testing_categories[:subject]]) * 3) : 1
  end 

  def input_error?(testing_categories)
    unless testing_categories.keys.include?(:grade)
      raise InsufficientInformationError, "A grade must be provided to answer this question"
    end 
    unless testing_categories[:grade] == 3 || testing_categories[:grade] == 8
      raise UnknownDataError, "#{testing_categories[:grade]} is not a known grade."
    end 
  end

  def truncate(float)
    (float * 1000).floor / 1000.to_f
  end
end