json.array!(@sfvs) do |sfv|
  json.extract! sfv, :id, :id, :data
  json.url sfv_url(sfv, format: :json)
end
