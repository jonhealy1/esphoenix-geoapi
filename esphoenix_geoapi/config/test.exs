import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :esphoenix_geoapi, EsphoenixGeoapiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "mOTJLIo3bHooABgZWXpmYuPB3FdKdRay1Nyy6rwH75zmJU639y+CKHNAXa7vN73t",
  server: false

# In test we don't send emails.
config :esphoenix_geoapi, EsphoenixGeoapi.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
