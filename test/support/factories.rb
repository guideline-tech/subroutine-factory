# frozen_string_literal: true

Subroutine::Factory.define :signup do
  op "::SignupOp"

  input :email, sequence { |n| "foo#{n}@example.com" }
  input :password, "password123"
end

Subroutine::Factory.define :random_signup do
  op "::SignupOp"

  input :email, random { |n| "foo#{n}@example.com" }
  input :password, "password123"

  output :user
end

Subroutine::Factory.define :user_signup do
  parent :signup
  output :user
end

Subroutine::Factory.define :business_signup, parent: :signup do
  op "::BusinessSignupOp"

  input :business_name, sequence { |n| "Business #{n}" }

  outputs :user, :business
end

Subroutine::Factory.define :ein_business_signup, parent: :business_signup do
  input :ein, "9204904"

  outputs %i[user business]
end
