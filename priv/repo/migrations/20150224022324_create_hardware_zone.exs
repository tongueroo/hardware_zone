defmodule HardwareZone.Repo.Migrations.CreateHardwareZone do
  use Ecto.Migration

  def up do
    create table(:hardwares) do
      add :name, :string
      add :description, :text
      add :manufacturer, :string
      add :sale_contact_number, :string

      # timestamps
    end
  end

  def down do
    drop table(:hardwares)
  end
end