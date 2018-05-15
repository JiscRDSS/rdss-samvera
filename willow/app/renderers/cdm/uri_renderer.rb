module Cdm
  class UriRenderer < StringRenderer
    class << self
      def render(text, href='#') #Can't use auto_link because of protocol types that are restricted by regex.
        %Q(<a href="#{href}">#{super(text)}</a>)
      end

      def call(text, href=nil)
        href||=text
        href.is_valid_uri? ? render(text, href) : super(text)
      end
    end
  end
end
