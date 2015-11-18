require_relative 'district_repository'
require_relative 'statewide_test'
class StatewideTestingAnalysis

  def initialize(district_repo)
    @district_repo = district_repo
    @statewide_tests = @district_repo.statewide_test_repo.statewide_tests
  end 

  def top_statewide_test_year_over_year_growth(testing_categories)
    input_error?(testing_categories)
    if testing_categories.has_key?(:subject)
      top = nil
      if testing_categories.has_key?(:top)
        top = testing_categories[:top]
      end
      (district_subject_growths(testing_categories).max(top) {|pair| pair[1]})
    end 
  end 


  def district_subject_growths(testing_categories)
    change = @statewide_tests.map do |state_test|
      array = state_test.proficient_by_grade(testing_categories[:grade]).to_a
      first = array[0][1][testing_categories[:subject]]
      last = array[-1][1][testing_categories[:subject]]
      [state_test.name, truncate(last - first)]
    end
 end

  def truncate(float)
    (float * 1000).floor / 1000.to_f
  end

  # def subject_leader(testing_categories)
    
  #   @district_repo.statewide_testing_repo.statewide_tests.map do |test|
  #     test
  #   end 



  #   #find the first year for each district in subject and take data value
  #   # => final year - first year / 2 
  #     #map district name and value into array so that if can be sorted by value


  # end 





  #   elsif ###find leading district for grade
  #     # growth_ranking = []
  #     # @district_repo.statewide_testing.find_by_name(district).each do |district|
  #     #   growth_ranking << [district, yearly_change(district)]
  #     # end 
  #     # growth_ranking.sort_by! {|district, growth| growth}
  #     # growth_ranking.last
    


  #   elsif testing_categories.has_key?(:top)
  #     growth_ranking.last(testing_categories[:top]) 

    

  #   elsif testing_categories.has_key?(:weighting)
  #     @district_repo.statewide_testing.find_by_name(district).each do |district|
  #       weighted_growth_ranking << [district, yearly_change(district)]
  #     end 
  #   end

  # end 


  # def subject_leader(testing_categories)
  #   scores_array = @district_repo.statewide_testing.----------map do |district|
  #     [district.name, yearly_growth(testing_categories, name)]
  #   scores_array.sort_by! {|district, growth| growth}
  #   scores_array.last
  #   end 
  # end 

  # def final_year_data(input_array)
  # end 

  # def first_year_data(input_array)
  # end

  # def growth_calculation
  # end 

  # def yearly_growth(input_array)
  #   subtractions = []
  #   if input_array.length >= 2 
  #     subtractions << (input_array[1] - input_array[0])
  #     input_array.shift
  #   else 
  #     subtractions.inject(:+) / subtractions.length
  #   end 
  # end 


  # def determine_weighting(testing_categories)
  #   unless testing_categories.has_key?(:weighting)
  #     testing_categories[:weighting] = even_weighting
  #   end 
  # end

  # def combined_weights_equals_one?(testing_categories)
  #   unless testing_categories[:weighting].values.inject(:+) == 1.0
  #     raise InsufficientInformationError, 
  #       "Weighted sum does not equal one"
  #   end  
  # end  

  # def even_weighting
  #   {math: 1.0/3, reading: 1.0/3, writing: 1.0/3}
  # end 
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