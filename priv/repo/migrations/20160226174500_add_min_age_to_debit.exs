defmodule Dinero.Repo.Migrations.AddMinAgeToDebit do
  use Ecto.Migration

  def change do 
  	alter table(:debits) do 
  		add :min_age, :integer 
    end
  end
end
