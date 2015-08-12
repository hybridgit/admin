json.array!(@permissions) do |permission|
  json.extract! permission, :id, :controller, :action
  json.url permission_url(permission, format: :json)
end
