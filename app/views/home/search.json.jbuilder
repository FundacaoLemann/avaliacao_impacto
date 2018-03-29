json.schools do
  json.array!(@schools) do |school|
    json.name school.name
    json.school_id school.inep
  end
end
