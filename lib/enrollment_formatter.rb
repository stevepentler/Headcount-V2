require_relative 'enrollment'
require 'pry'

class EnrollmentFormatter

  attr_reader :enrollments_hash

  def initialize
    @enrollments_hash = []
  end

  def district_governor(enrollments_csv)
    enrollments_csv[:enrollment].each do |category, enrollment_rows|
      category = format_category(category)
  
      enrollment_rows.each do |row|
        if @enrollments_hash.empty?
          district_yearly_data(category, row)
        else
          unique_enrollment?(category, row)
        end
      end
    end
  end

  def unique_enrollment?(category, row)
      if hash_find(row)
        merge_enroll_data(hash_find(row), category, row)
      else
        district_yearly_data(category, row)
      end
  end

  def hash_find(row)
    @enrollments_hash.find {|enrollment| enrollment[:name] == row[:location]}
  end

  def yearly_data(row)
    sub_hash = {row[:timeframe] => row[:data]}
  end

  def district_yearly_data(category, row)
    @enrollments_hash << {:name => row[:location], category => (yearly_data(row))}
  end


  def merge_enroll_data(enrollment, category, row)
    if enrollment.has_key?(category)
      enrollment[category].merge!(yearly_data(row))
    else
      enrollment.merge!({category => yearly_data(row)})
    end
  end

  def format_category(category)
    category = :kindergarten_participation if category == :kindergarten
    category
  end 


end
