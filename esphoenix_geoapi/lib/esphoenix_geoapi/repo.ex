defmodule EsphoenixGeoapi.Repo do
  use Ecto.Repo,
    otp_app: :esphoenix_geoapi,
    adapter: Ecto.Adapters.Postgres
end
