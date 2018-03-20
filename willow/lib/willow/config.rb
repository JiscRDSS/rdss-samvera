module Willow
  class Config
    def self.institution_jisc_id
      ENV['INSTITUTION_JISC_ID'] || 0
    end

    def self.institution_name
      ENV['INSTITUTION_NAME'] || 'RDSS Samvera'
    end

    def self.institution_name_full
      ENV['INSTITUTION_NAME_FULL'] || 'Jisc RDSS Samvera'
    end

    def self.institution_logo
      ENV['INSTITUTION_LOGO'] || ''
    end
  end
end
