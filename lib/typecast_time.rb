# TypecastTime

module TypecastTime
    def typecast_time(*symbols)
     pattern = {:format => ["%d"," ","%b"," ", "%y"]}
     pattern.update(symbols.extract_options!)
     date_pattern = ""
     pattern[:format].each{|i| date_pattern = date_pattern + i}
     symbols.each do |symbol|
      class_eval %{
      def #{symbol}
       Time.at(read_attribute(:#{symbol})).strftime('#{date_pattern}')
      end

      def #{symbol}=(value)
       write_attribute(:#{symbol}, Time.parse(value).to_i)
      end

      def #{symbol}_before_typecast_time(#{symbol}_name)
       read_attribute_before_type_cast(#{symbol}_name)
      end
      }
     end
    end

end
