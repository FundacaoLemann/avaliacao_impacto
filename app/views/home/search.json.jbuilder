json.mec_schools do
  json.array!(@mec_schools) do |mec_school|
    json.name mec_school.to_s
  end
end
