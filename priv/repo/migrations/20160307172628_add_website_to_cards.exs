defmodule Dinero.Repo.Migrations.AddWebsiteToCards do
  use Ecto.Migration

  def change do
  	alter table(:credits) do
  		add :website, :string
  	 
  	end

  	alter table(:debits) do
  		add :website, :string
  	 
  	end
  end
end
