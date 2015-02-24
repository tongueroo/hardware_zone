defmodule HardwareZone.HardwaresController do
  use Phoenix.Controller
  alias HardwareZone.Hardware
  alias HardwareZone.Repo
  import HardwareZone.Router.Helpers

  plug :action

  def index(conn, _params) do
    hardwares = HardwareZone.Queries.all_hardwares
    render conn, "index.html", hardwares: hardwares
  end

  def new(conn, _params) do
    render conn, "new.html", hardware: %Hardware{}
  end

  def create(conn, %{"hardware" => params}) do
    changeset = Hardware.changeset %Hardware{}, params

    if changeset.valid? do
      hardware = Repo.insert(changeset)
      redirect conn, to: hardwares_path(conn, :show, hardware.id)
    else
      hardware = Map.merge(%Hardware{}, params)
      render conn, "new.html", hardware: hardware
    end
  end

  def show(conn, %{"id" => id}) do
    case hardware = Repo.get(Hardware, id) do
      hardware when is_map(hardware) ->
        render conn, "show.html", hardware: hardware
      _ ->
        redirect conn, to: hardwares_path(conn, :index)
    end
  end
  

end