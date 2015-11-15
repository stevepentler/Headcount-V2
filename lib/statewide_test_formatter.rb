require_relative 'state_wide_test'
require 'pry'

class EnrollmentFormatter

  def yearly_data(row)
    sub_hash = {row[:subject] => row[:data].to_f.round(3)}
  end

  def district_yearly_data(category, row)
    enrollment = Enrollment.new({:name => row[:location]})
    merge_enroll_data(enrollment, {row[:timeframe] => yearly_data(row)}
    enrollment
  end

  def append_district_yearly_data(enrollment, category, row)
    merge_enroll_data(enrollment, {category => yearly_data(row)})
  end

  def merge_test_data(enrollment, enroll_data)
    if enroll_data.has_key?([category])
      merge_test_by_race(enrollment, enroll_data)
    else
      merge_test_by_grade(enrollment, enroll_data)
    end
  end

  def merge_test_by_race(enrollment, enroll_data)
    if enrollment.by_race.has_key?([race][year])
      enrollment.by_race.merge!(enroll_data[race][year])
    elsif enrollment.by_race
      enrollment.by_race.merge!(enroll_data[race])
    end
  end

  def merge_test_by_grade(enrollment, enroll_data)
    if enrollment.by_grade.has_key?([grade][year])
      enrollment.by_race.merge!(enroll_data[grade][year])
    else
      enrollment.by_grade.merge!(enroll_data[grade])
    end
end

#by_grade =
#      {3 =>
#           { 2008 => {:math => 0.857, :reading => 0.866, :writing => 0.671},
  #           2009 => {:math => 0.824, :reading => 0.862, :writing => 0.706},
  #           2010 => {:math => 0.849, :reading => 0.864, :writing => 0.662},
  #           2011 => {:math => 0.819, :reading => 0.867, :writing => 0.678},
  #           2012 => {:math => 0.830, :reading => 0.870, :writing => 0.655},
  #           2013 => {:math => 0.855, :reading => 0.859, :writing => 0.668},
  #           2014 => {:math => 0.834, :reading => 0.831, :writing => 0.639}
  #    },
  #    8 =>
  #         { 2008 => {:math => 0.857, :reading => 0.866, :writing => 0.671},
  #           2009 => {:math => 0.824, :reading => 0.862, :writing => 0.706},
  #           2010 => {:math => 0.849, :reading => 0.864, :writing => 0.662},
  #           2011 => {:math => 0.819, :reading => 0.867, :writing => 0.678},
  #           2012 => {:math => 0.830, :reading => 0.870, :writing => 0.655},
  #           2013 => {:math => 0.855, :reading => 0.859, :writing => 0.668},
  #           2014 => {:math => 0.834, :reading => 0.831, :writing => 0.639}
