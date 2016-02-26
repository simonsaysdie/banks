defmodule Dinero.Repo.Migrations.CreateDebit do
  use Ecto.Migration

  def change do
    create table(:debits) do
      add :name, :string
      add :requirements, :text
      add :opening, :integer
      add :max_age, :integer
      add :promo, :boolean, default: false
      add :insurance, :boolean, default: false

      timestamps
    end

  end
end
