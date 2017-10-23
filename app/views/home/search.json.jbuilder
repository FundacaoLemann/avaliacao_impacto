json.schools do
  json.array!(@schools) do |school|
    json.name school.to_s
  end
end
