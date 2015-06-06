json.array!(@datasets) do |dataset|
  json.extract! dataset, :id, :date_updated, :expected_frequency_of_update, :url, :date_created
  json.url dataset_url(dataset, format: :json)
end
