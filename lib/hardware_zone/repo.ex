defmodule HardwareZone.Repo do
  use Ecto.Repo,
    otp_app: :hardware_zone,
    adapter: Ecto.Adapters.Postgres
end