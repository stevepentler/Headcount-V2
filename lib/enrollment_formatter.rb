require_relative 'enrollment'
require 'pry'

class EnrollmentFormatter

  def yearly_data(row)
    sub_hash = {row[:timeframe] => row[:data].to_f.round(3)}
  end

  def district_yearly_data(category, row)
    enrollment = Enrollment.new({:name => row[:location]})
    merge_enroll_data(enrollment, {category => yearly_data(row)})
    enrollment
  end

  def append_district_yearly_data(enrollment, category, row)
    merge_enroll_data(enrollment, {category => yearly_data(row)})
  end

  def merge_enroll_data(enrollment, enroll_data)
    if enroll_data.has_key?(:kindergarten)
      enrollment.kindergarten_data.merge!(enroll_data[:kindergarten])
    elsif enroll_data.has_key?(:high_school_graduation)
      enrollment.graduation_data.merge!(enroll_data[:high_school_graduation])
    end
  end
end