# frozen_string_literal: true

require_relative "classify/version"
require_relative "classify/complex"
require_relative "classify/simple"

module Classify
  class Error < StandardError; end
end
