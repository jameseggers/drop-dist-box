json.extract! node, :id, :name, :ip_address, :type, :created_at, :updated_at
json.url node_url(node, format: :json)