module Classify
  # ---------------------------------------COMPLEX PARSER-----------------------------------------
  # SHOULD process ANY Hash object return, if object if failing, it is likely that a key is not getting transformed
  # correctly, add that character to the transformation string to process correctly.
  class Complex
    # Only Assumption is that base level object is a Hash Array or Hash Object
    def initialize(i, key: nil)
      case i
      when Array
        process_array(i, key: key)
      when Hash
        process_hash(i)
      else
        puts 'Base object must be Hash Object or Array'
      end
    end

    def process_array(i, key: nil)
      attr_key = key ? sanatize_key(key) : 'array'
      array = []
      unless i.empty?
        i.each do |array_item|
          array << case array_item.class.to_s.to_sym
                   when :Hash || :Array
                     Complex.new(array_item)
                   else
                     array_item
                   end
        end
      end
      self.class.attr_accessor(attr_key)
      send("#{attr_key}=", array)
      instance_variable_set("@#{attr_key}", array)
    end

    def process_hash(i)
      i.each do |key, value|
        if key[-1, 1] == '?'
          handle_method(key: key, value: value)
        else
          k_underscore = (key.instance_of? Symbol) ? key : sanatize_key(key)
          case value
          when Hash
            res = Complex.new(value, key: k_underscore)
            self.class.attr_accessor
            self.class.attr_accessor(k_underscore)
            send("#{k_underscore}=", res)
            instance_variable_set("@#{k_underscore}", res)
          when Array
            process_array(value, key: k_underscore)
          else
            self.class.attr_accessor(k_underscore)
            send("#{k_underscore}=", value)
            instance_variable_set("@#{k_underscore}", value)
          end
        end
      end
    end


    def sanatize_key(key)
      # If this is to be responses may contain improper keys, uncomment and implement for all attr names
      # the PrimeTrust API responses only need to be underscored as they do not contain leading integers or dis-allowed characters
      key[0,1] =~ /^[0-9].*/ ? "_#{key.tr(':', '_').underscore}" : key.tr(':', '_').underscore
    end

    # Allows us to handle methods ending with '?' as Singleton Methods
    def handle_method(key:, value:)
      define_singleton_method(key) do
        return value
      end
    end

    def keys
      instance_variables
    end
  end
end