class CdmIdentifierRenderer 
  class << self
    def call(type, value)
      send(type, value)
    end

    def url(value)
      render_url(value, value)
    end

    def doi(value)
      url, display = DoiNormaliser.(value)
      render_url(url, display)
    end

    def render_url(href, text)
      %Q(<a href="#{href}">#{text}</a>) 
    end

    def method_missing(m_name, value)
      value
    end

  end
end
