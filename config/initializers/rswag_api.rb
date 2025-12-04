Rswag::Api.configure do |c|
  # Where Swagger (OpenAPI) files live
  c.openapi_root = Rails.root.join("config", "openapi").to_s

  # Required to allow .erb parsing
  c.openapi_format = :yaml
end