class Enrollment

  attr_reader :name, :yearly_data, :kindergarten_data, :graduation_data

  def initialize(enrollment_data)
    @name = enrollment_data[:name]
    @kindergarten_data = {}
    @graduation_data = {} #only passing in final year of graduation rate, merge is messed up
  end

  def kindergarten_participation_by_year
    kindergarten_data
  end

  def kindergarten_participation_in_year(year)
    kindergarten_data[year]
  end

  def graduation_rate_by_year
    graduation_data
  end 

  def graduation_rate_in_year(year)
    graduation_data[year]
  end 
end