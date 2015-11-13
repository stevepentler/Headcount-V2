
class Enrollment

  attr_reader :name, :yearly_data

  def initialize(enrollment_data)
    @name = enrollment_data[:name]
    @participation_years = enrollment_data[:yearly_data]
  end

  def kindergarten_participation_by_year
    participation_years
  end 

  def kindergarten_participation_in_year(year)
    participation_years[year]
  end

  def graduation_rate_by_year
  end 

  def graduation_rate_in_year(year)
  end 
end