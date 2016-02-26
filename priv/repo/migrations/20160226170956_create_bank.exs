defmodule Dinero.Repo.Migrations.CreateBank do
  use Ecto.Migration

  def change do
    create table(:banks) do
      add :name, :string
      add :website, :string

      timestamps
    end

  end
end
