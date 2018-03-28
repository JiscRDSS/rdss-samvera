module Hyrax
  module Serializers
    private
    def separator
      ' | '
    end

    def string_title
      title.kind_of?(String) && title.to_s
    end

    def array_title
      title.respond_to?(:join) && title.join(separator)
    end

    def display_title
      string_title || array_title
    end

    public
    def to_s
      display_title || label || I18n.t('hyrax.no_title')
    end
  end
end
