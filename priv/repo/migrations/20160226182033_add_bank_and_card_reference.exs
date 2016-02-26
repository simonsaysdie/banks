defmodule Dinero.Repo.Migrations.AddBankAndCardReference do
  use Ecto.Migration

  def change do
  	alter table(:credits) do
  		add :bank_id, references(:banks)
  	 
  	end

  	alter table(:debits) do
  		add :bank_id, references(:banks)
  	 
  	end
  end
end
