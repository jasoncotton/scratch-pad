json.array!(@regexes) do |regex|
  json.extract! regex, :id, :id, :regex, :description, :status, :ordinal, :group_name
  json.url regex_url(regex, format: :json)
end
