class DateFromFormat
  class << self
    def call(date_value, format)
      begin
        ::DateTime.strptime(date_value, format)
      rescue
        nil
      end
    end
  end
end
