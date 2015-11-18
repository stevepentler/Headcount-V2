class Enrollment

  attr_reader :name, :yearly_data, :kindergarten_data, :graduation_data

  def initialize(enrollment_data)
    @name = enrollment_data[:name]
    @kindergarten_data= enrollment_data[:kindergarten_participation]
    @graduation_data = enrollment_data[:high_school_graduation]
  end

  def kindergarten_participation_by_year
    kindergarten_data
  end

  def kindergarten_participation_in_year(year)
    kindergarten_data.nil? ? nil : truncate(kindergarten_data[year])
  end

  def graduation_rate_by_year
    graduation_data
  end

  def graduation_rate_in_year(year)
    truncate(graduation_data[year])
  end

  def truncate(float)
    (float * 1000).floor / 1000.to_f unless float == nil
  end

end
