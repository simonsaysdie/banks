defmodule Dinero.Repo.Migrations.DeleteOpeningFromCredit do
  use Ecto.Migration

  def change do
  	alter table(:credits) do 
  		remove :opening
  	end
  end
end
