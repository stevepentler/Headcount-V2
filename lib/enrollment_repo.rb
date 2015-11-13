class EnrollmentRepository
  
  def initialize
    @enrollments = []
  end 

  def load_data
  end

   def unique_enrollment?(parse)
    empty?(parse)
    @districts.each do |district|
      instantiate_districts(parse) if district.name != parse[:location]
    end
  end

  def empty?(parse)   
     instatiate_enrollments if @districts.empty?
  end
  
  def instatiate_enrollments
    @enrollments << EnrollmentFormatter.new.district_yearly_data(row)
  end 

  def find_by_name(name)
  end 

  def find_by_matching
  end



end 