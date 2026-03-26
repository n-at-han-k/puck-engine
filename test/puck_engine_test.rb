# frozen_string_literal: true

require "test_helper"

class PuckEngineTest < Minitest::Test
  def test_version
    refute_nil PuckEngine::VERSION
  end
end
