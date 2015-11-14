require 'enrollment_formatter'
require 'pry'
class EnrollmentRepository

  attr_reader :enrollments
  
  def initialize
    @enrollments = []
    @enrollment_formatter = EnrollmentFormatter.new
  end 

  def load_data(parsed_csv)
    enrollments_csv = parsed_csv[:enrollment]
    district_governor(enrollments_csv)
  end

  def district_governor(enrollments_csv)
    enrollments_csv.each do |category, enrollment_rows|
      enrollment_rows.each do |row|
        if @enrollments.empty?
          empty?(category, row)
        else
          unique_enrollment?(category, row)
        end
      end
    end
  end

  def unique_enrollment?(category, row)
    enrollment = find_by_name(row[:location])
    if enrollment == nil
      @enrollments << @enrollment_formatter.district_yearly_data(category, row)
    else
      @enrollment_formatter.append_district_yearly_data(enrollment, category, row)
    end
  end

  def empty?(category, row)   
     @enrollments << @enrollment_formatter.district_yearly_data(category, row)
  end

  def find_by_name(name)
    @enrollments.find do |enrollment|
      name.upcase == enrollment.name.upcase
    end
  end 

  def find_by_matching
    find_all = @enrollments.select do |enrollment|
      enrollment if enrollment.name.include?(word_fragment.upcase)
    end
    find_all
  end
end 