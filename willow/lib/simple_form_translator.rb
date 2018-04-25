class SimpleFormTranslator
  class << self
    def call(namespace, model, attribute, default=' ')
      lookups     = [
        :"#{model}.#{attribute}",
        :"defaults.#{attribute}",
        default
      ]

      I18n.t(lookups.shift, scope: :"simple_form.#{namespace}", default: lookups).presence
    end
  end
end
