module Main
  module Softspoken
    class << self
      fattr 'softspoken' => true
      def on!() softspoken(true) end 
      def off!() softspoken(false) end 
      def === other
        softspoken ? super : false
      end
    end
  end
end
