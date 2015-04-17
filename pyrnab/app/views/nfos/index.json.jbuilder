json.array!(@nfos) do |nfo|
  json.extract! nfo, :id, :id, :data
  json.url nfo_url(nfo, format: :json)
end
