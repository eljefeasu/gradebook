class Student < ActiveRecord::Base
  has_secure_password
  has_many :parents
  has_many :grades
  belongs_to :teacher
end
