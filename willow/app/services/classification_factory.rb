class ClassificationFactory
  attr_reader :options
  class << self
    public
    def default_options
      {
        namespace: Enumerations
      }
    end

    def call(name, options={})
      new(options).call(name)
    end
  end

  private
  def initialize(options={})
    @options=self.class.default_options.merge(options)
  end

  def namespace
    options[:namespace]
  end

  public
  def call(name)
    namespace::const_get(name.classify)
  end
end