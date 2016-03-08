json.array!(@grades) do |grade|
  json.extract! grade, :id, :grade, :assignment_name, :date_due, :student_id
  json.url grade_url(grade, format: :json)
end
