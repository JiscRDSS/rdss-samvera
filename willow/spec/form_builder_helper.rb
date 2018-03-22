require 'capybara/rspec'

class FormBuilderTemplate < Object
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormOptionsHelper

  def controller
    self
  end

  def action_name
    :new
  end
end

class FormBuilderHelper
  class << self
    def template
      @template=FormBuilderTemplate.new
    end
  end
end