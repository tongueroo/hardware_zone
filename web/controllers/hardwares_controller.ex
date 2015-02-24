defmodule HardwareZone.HardwaresController do
  use Phoenix.Controller
  alias HardwareZone.Hardware
  alias HardwareZone.Repo
  import HardwareZone.Router.Helpers

  def index(conn, _params) do
    hardwares = HardwareZone.Queries.all_hardwares
    render conn, "index.html", hardwares: hardwares
  end
end