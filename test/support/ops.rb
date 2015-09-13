class SignupOp < ::Subroutine::Op

  string :email
  string :password

  attr_reader :user

  validates :email, presence: true
  validates :password, presence: true

  def perform
    @user = {
      email: email,
      password: password
    }
    true
  end
end


class BusinessSignupOp < ::SignupOp

  string :business_name
  attr_reader :business

  validates :business_name, presence: true

  def perform
    return false unless super
    @business = {
      name: business_name
    }
    true
  end

end
