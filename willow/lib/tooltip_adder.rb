class TooltipAdder
  class << self
    def call(tooltip)
      tooltip.present? ? { title: tooltip } : nil
    end
  end
end
