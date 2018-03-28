class FitsToRfc3339
  class << self
    private
    def candidate_regexen
      [
        '%Y:%m:%d %H:%M:%S%Z',
        '%Y:%m:%d %H:%M:%S',
        '%Y:%m:%d',
        '%Y:%m',
        '%Y'
      ]
    end

    public
    def call(date_value, formats=candidate_regexen)
      new(date_value).call(formats)
    end
  end

  private
  attr_reader :date_value

  def initialize(date_value)
    @date_value=date_value
  end

  def first_valid_formatted_date(formats)
    ::Array.wrap(formats).lazy.map { |format| ::DateFromFormat.(date_value, format) }.find(&:itself)
  end

  public
  def call(formats=self.class.candidate_regexen)
    ( first_valid_formatted_date(formats) || ::Time.at(0) ).rfc3339
  end
end