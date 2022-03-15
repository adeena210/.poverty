json.extract! entry, :id, :name, :address, :description, :verified, :created_at, :updated_at
json.url entry_url(entry, format: :json)
