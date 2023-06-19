# frozen_string_literal: true

require_relative "hashlation/version"

module Hashlation
  # SHOULD process ANY Hash object return, if object if failing it is likely that a key is not getting transformed correctly.
  # Add that character to the transformation string to process correctly.
  class Any
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
      attr_key = key ? key.underscore : 'array'
      array = []
      unless i.empty?
        i.each do |array_item|
          array << case array_item
                   when Hash || Array
                     Any.new(array_item)
                   else
                     array_item
                   end
        end
      end
      begin
        self.class.attr_accessor(attr_key)
        send("#{attr_key}=", array)
        instance_variable_set("@#{attr_key}", array)
      rescue NameError
        handle_complex_key(attr_key, value)
      end
    end

    def process_hash(i)
      i.each do |key, value|
        if key[-1, 1] == '?'
          handle_method(key: key, value: value)
        else
          k_underscore = (key.instance_of? Symbol) ? key : key.underscore
          case value
          when Hash
            res = Any.new(value, key: k_underscore)
            begin
              self.class.attr_accessor(k_underscore)
              send("#{k_underscore}=", res)
              instance_variable_set("@#{k_underscore}", res)
            rescue NameError
              handle_complex_key(k_underscore, res)
            end
          when Array
            process_array(value, key: k_underscore)
          else
            begin
              self.class.attr_accessor(k_underscore)
              send("#{k_underscore}=", value)
              instance_variable_set("@#{k_underscore}", value)
            rescue NameError
              handle_complex_key(k_underscore, value)
            end
          end
        end
      end
    end

    # Use Begin/Rescue to submit complex keys be sanitized and written to attr_accessor without needlessly checking keys.
    def handle_complex_key(key, value)
      k_special_underscore = key[0,1] =~ /^[0-9].*/ ? "_#{key.tr(':', '_').underscore}" : key.tr(':', '_').underscore
      self.class.attr_accessor(k_special_underscore)
      send("#{k_special_underscore}=", value)
      instance_variable_set("@#{k_special_underscore}", value)
    end

    # Allows us to handle methods ending with '?' as Singleton Methods
    def handle_method(key:, value:)
      define_singleton_method(key) do
        return value
      end
    end

    # Get keys at this object level.
    def keys
      instance_variables
    end

    # Test if Key is defined on this object level.
    def key?(key)
      instance_variable_defined?("@#{key}")
    end
  end

end
