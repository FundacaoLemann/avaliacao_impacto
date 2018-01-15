json.state_allowed_administrations @state_allowed_administrations.map(&:state_or_city)
json.city_allowed_administrations @city_allowed_administrations.map(&:state_or_city)
