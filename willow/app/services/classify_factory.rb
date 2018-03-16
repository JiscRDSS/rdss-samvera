class ClassifyFactory
  attr_reader :options
  class << self
    public
    def default_options
      {
        root: Enumerations
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

  def root
    options[:root]
  end

  public
  def call(name)
    root::const_get(name.classify)
  end
end