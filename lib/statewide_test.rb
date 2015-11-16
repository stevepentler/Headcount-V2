class StatewideTest

  attr_reader :name, :by_grade, :by_race

  def initialize(statewide_test_data)
    @name = statewide_test_data[:name]
    @by_grade = {}
    @by_race  = {}
  end

  def proficient_by_grade(grade)
    by_grade[grade]
  end

  def proficient_by_race_or_ethnicity(race)
    by_race[race]
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
  end

  def graduation_rate_in_year(year)
    graduation_data[year]
  end
end
