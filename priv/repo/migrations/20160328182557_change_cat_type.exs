defmodule Dinero.Repo.Migrations.ChangeCatType do
  use Ecto.Migration

  def change do
    alter table(:credits) do
      remove :cat 
      add :cat, :real  
    end 
  end
end
