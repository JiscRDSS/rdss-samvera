require 'spec_helper'
require 'form_builder_helper'
require_relative 'facets/input'
require_relative 'facets/labelled'
require_relative 'facets/named'
require_relative 'facets/numeric'
require_relative 'facets/optional'
require_relative 'facets/required'
require_relative 'facets/selected'
require_relative 'facets/text_area'
require_relative 'facets/unlabelled'

class FacetsProxy
  class << self
    def call(klass, proxy)
      klass.new(:foo, proxy.new, FormBuilderHelper.template, {})
    end
  end
end