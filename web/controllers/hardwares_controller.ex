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
      hardware = Ecto.Changeset.apply(changeset)
      render conn, "new.html", hardware: hardware, errors: changeset.errors
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
  
  def edit(conn, %{"id" => id}) do
    case Repo.get(Hardware, id) do
      hardware when is_map(hardware) ->
        render conn, "edit.html", hardware: hardware
      _ ->
        redirect conn, to: hardwares_path(conn, :index)
    end
  end

  def update(conn, %{"id" => id, "hardware" => params}) do
    case Repo.get(Hardware, id) do
      hardware when is_map(hardware) ->
        changeset = Hardware.changeset Repo.get(Hardware, id), params

        if changeset.valid? do
          Repo.update(changeset)
          redirect conn, to: hardwares_path(conn, :show, hardware.id)
        else
          hardware = Ecto.Changeset.apply(changeset)
          render conn, "edit.html", hardware: hardware, errors: changeset.errors
        end
       _ ->
       redirect conn, to: hardwares_path(conn, :index)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Repo.get(Hardware, id) do
      hardware when is_map(hardware) ->
        Repo.delete(hardware)
        redirect conn, to: hardwares_path(conn, :index)
      _ ->
        redirect conn, to: hardwares_path(conn, :index)
    end
  end
end