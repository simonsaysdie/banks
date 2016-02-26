defmodule Dinero.Repo.Migrations.CreateCredit do
  use Ecto.Migration

  def change do
    create table(:credits) do
      add :name, :string
      add :requirements, :text
      add :opening, :integer
      add :min_age, :integer
      add :max_age, :integer
      add :promo, :boolean, default: false
      add :insurance, :boolean, default: false
      add :cat, :integer
      add :annual, :integer
      add :additional_cards, :boolean, default: false
      add :min_income, :integer

      timestamps
    end

  end
end
