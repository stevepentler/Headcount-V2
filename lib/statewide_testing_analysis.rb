class StatewideTestingAnalysis

  include KeywordParser

  def top_statewide_test_year_over_year_growth(grade: 3, subject: :math)

    if argument = (subject: :math)
      #raise InsufficientInformationError: "A grade must be provided to answer this question"
    elsif argument = (grade:, subject: :math)
      #if grade != 3 || grade != 8
        #raise UnknownDataError: "#{grade:}" is not a known grade"
    elsif arguement = (grade: 3, subject: :math)
    #grade_parser(information)
    #take in subject data for year 1, year 2, year 3
    #map through
    #((year 2 - year 1) + (year 3 - year 2))/2
    #returned array.sort.last 
#method returns district name with growth integer (over n years)
      #(sort_by if not in numerical order)
    elsif argument = (grade: 3, top: 3, subject: :math)
      #grade_parser(information)
      #same method as above
      #take last(# from top)
    elsif argument = (grade: 3)
      #grade_parser(information)
      #iterate through each subject :math, :reading, :writing
      #run same method as above for each 
      #(assign index aka ranking to each item in index)???
      #add all three rankings together for school and divide by 3???
#method returns top district name for (:math_integer + :reading_integer + :writing_integer) / 3
    elsif (grade: 8, :weighting => {:math = 0.5, :reading => 0.5, :writing => 0.0})
#method returns top district for each subject in a grade and the growth rate across all 3
      #


  end

end 