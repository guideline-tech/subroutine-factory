$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'subroutine/factory'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use!([Minitest::Reporters::DefaultReporter.new])

require "support/ops"
require "support/factories"
