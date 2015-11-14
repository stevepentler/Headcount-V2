require 'enrollment_formatter'
require 'pry'
class EnrollmentRepository
  
  def initialize
    @enrollments = []
    @enrollment_formatter = EnrollmentFormatter.new
  end 

  def load_data(parsed_csv)
    binding.pry
    enrollments_csv = parsed_csv[:enrollment]
    district_governor(enrollments_csv)
  end

  def district_governor(enrollments_csv)
    enrollments_csv.each do |category, enrollment_rows|
      enrollment_rows.each do |row|
        empty?(category, row) if @enrollments.empty?
        unique_enrollment?(category, row)
      end
    end
  end

  def unique_enrollment?(category, row)
    if find_by_name(row[:location]) == nil
      @enrollments << @enrollment_formatter.district_yearly_data(category, row)
    else
      @enrollment_formatter.append_district_yearly_data(catergory, row)
    end
  end

  def empty?(category, row)   
     @enrollments << @enrollment_formatter.district_yearly_data(category, row)
  end

  def find_by_name(name)
  end 

  def find_by_matching
  end



end 