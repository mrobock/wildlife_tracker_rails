json.extract! sighting, :id, :sighting_time, :latitude, :longitude, :animal_id, :created_at, :updated_at
json.url sighting_url(sighting, format: :json)