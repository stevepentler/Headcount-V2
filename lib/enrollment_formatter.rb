require_relative 'enrollment'

class EnrollmentFormatter

  def yearly_data(row)
    sub_hash = {row[:timeframe] => row[:data].to_f.round(3)}
  end

  def district_yearly_data(row)
    Enrollment.new({name: row[:location], yearly_data: yearly_data(row)})
  end

  def append_district_yearly_data(enrollment, row)
    enrollment.participation_years.merge!(pair_year_percentage(row))
  end

end 