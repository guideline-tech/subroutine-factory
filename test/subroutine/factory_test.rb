require 'test_helper'

class Subroutine::FactoryTest < Minitest::Test

  def test_it_registers_factories
    require "support/factories"

    assert_equal 4, ::Subroutine::Factory::configs.length
  end

  def test_it_enables_ops_to_be_wrapped_with_simple_factories
    op = Subroutine::Factory.create(:signup)
    assert_equal ::SignupOp, op.class

    refute_nil op.user
  end

  def test_it_enables_the_spec_helper_to_be_mixed_in
    extend ::Subroutine::Factory::SpecHelper
    op = factory(:signup)
    assert_equal ::SignupOp, op.class
  end

  def test_it_blows_up_if_invalid_data_is_supplied
    assert_raises(Subroutine::Failure) {
      Subroutine::Factory.create(:signup, {email: nil})
    }
  end

  def test_it_allows_data_to_be_sequenced
    base = ::Subroutine::Factory.sequence
    assert_equal "foo#{base+1}@example.com", Subroutine::Factory.create(:user_signup)[:email]
    assert_equal "foo#{base+2}@example.com", Subroutine::Factory.create(:user_signup)[:email]
  end

  def test_it_allows_factories_to_inherit_configs_from_parents
    base = ::Subroutine::Factory.sequence
    user, business = ::Subroutine::Factory.create(:ein_business_signup)

    assert_equal "foo#{base+1}@example.com", user[:email]
    assert_equal "password123", user[:password]
    assert_equal "Business #{base+2}", business[:name]
  end

end
