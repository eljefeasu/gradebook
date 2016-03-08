json.array!(@students) do |student|
  json.extract! student, :id, :name, :email, :teacher_id, :parent_id, :password_digest
  json.url student_url(student, format: :json)
end
