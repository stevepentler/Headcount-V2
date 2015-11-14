
class Enrollment

  attr_reader :name, :yearly_data, :kindergarten_data

  def initialize(enrollment_data)
    @name = enrollment_data[:name]
    @kindergarten_data = enrollment_data[:kindergarten]
    @graduation_data = {}
  end

  def merge_enroll_data(enroll_data)
    if enroll_data.has_key?(:kindergarten)
      @kindergarten_data.merge!(enroll_data[:kindergarten])
    elsif enroll_data.has_key?(:high_school_graduation)
      @graduation_data.merge!(enroll_data)
    end
  end

  def kindergarten_participation_by_year
    kindergarten_data
  end 

  def kindergarten_participation_in_year(year)
    kindergarten_data[year]
  end

  def graduation_rate_by_year
  end 

  def graduation_rate_in_year(year)
  end 
end