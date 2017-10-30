json.schools do
  json.array!(@schools) do |school|
    json.name school.to_s
    json.school_id school.id
  end
end
