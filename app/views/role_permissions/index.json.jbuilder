json.array!(@role_permissions) do |role_permission|
  json.extract! role_permission, :id, :role_id, :permission_id
  json.url role_permission_url(role_permission, format: :json)
end
