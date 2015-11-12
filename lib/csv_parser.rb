class CSVParser

    attr_reader 

  def initialize(csv_paths)
    @csv_paths = csv_paths
    @parsed_csv = {}
    seperate_category
  end

  def seperate_category
    @csv_paths.each do |category, data_type|
      seperate_data(data_type)
      @parsed_csv.merge!({category => @parsed_data})
    end
  end

  def seperate_data_type(data_type)
    @parsed_data = {}
    data_type.each do |sub_category, data_path|
      handle = CSV.read(data_path, :headers => true, header_converters: :symbol)
      handle.each do |row|
        @parsed_data << row
      end
    end
  end

  def csv_row_format
  end 

end 