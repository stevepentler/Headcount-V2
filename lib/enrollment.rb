
class Enrollment

  attr_reader :name, :yearly_data, :participation_years

  def initialize(enrollment_data)
    @name = enrollment_data[:name]
    @participation_years = enrollment_data
  end

  def kindergarten_participation_by_year
  end 

  def kindergarten_participation_in_year(year)
  end

  def graduation_rate_by_year
  end 

  def graduation_rate_in_year(year)
  end 
end