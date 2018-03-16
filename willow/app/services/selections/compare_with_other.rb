# This class takes two entries in an array suitable for a drop down list and sorts them by the display values but always
# keeps the entries represented by :other and :unknown at the end of the list in that order.
# Note that the ordering of the comparisons is important in this case, since we want 'other' to be followed by 'unknown'
module Selections
  class CompareWithOther
    class << self
      def call(a,b)
        case
        when b[1]==:unknown
          -1
        when a[1]==:unknown
          1
        when b[1]==:other
          -1
        when a[1]==:other
          1
        else
          a[0].downcase <=> b[0].downcase
        end
      end
    end
  end
end