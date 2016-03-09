class Parent < ActiveRecord::Base
  has_secure_password
  has_one :student
end
