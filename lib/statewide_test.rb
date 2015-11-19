require_relative 'standard_errors'
class StatewideTest

  attr_reader :name, :statewide_test_data

  def initialize(statewide_test_data)
    @name = statewide_test_data[:name]
    @statewide_test_data = delete_district_name(statewide_test_data)
  end

  def delete_district_name(statewide_test_data)
    statewide_test_data.delete_if {|key, value| key == :name}
  end

  def proficient_by_grade(grade)
    fail UnknownDataError, 'Unknown grade requested' unless grade == 3 || grade == 8
      statewide_test_data[grade]
  end

  def proficient_by_race_or_ethnicity(race)
    fail UnknownDataError, 'Unknown grade requested' unless statewide_test_data.has_key?(race)
      statewide_test_data[race]
  end

  def proficient_for_subject_by_grade_in_year(subject_, grade, year)
    return "N/A" if statewide_test_data[grade][year][subject_] == 0.0
    if statewide_test_data[grade][year][subject_] != nil
      statewide_test_data[grade][year][subject_]
    else
      fail UnknownDataError, 'Unknown grade requested'
    end
  end

  def proficient_for_subject_by_race_in_year(subject_, race, year)
    fail UnknownDataError, 'Unknown grade requested' unless race_and_year_exist(subject_, race, year)
      statewide_test_data[race][year][subject_]
  end

  def race_and_year_exist(subject_, race, year)
    statewide_test_data[race] && statewide_test_data[race][year][subject_] != nil
  end

end
