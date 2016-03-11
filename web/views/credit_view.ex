defmodule Dinero.CreditView do
  use Dinero.Web, :view

  def parse_banks(banks) do
    banks = Enum.map(banks, fn(bank) -> 
              {String.to_atom(bank.name), bank.id}
            end)
    List.flatten [banks]
  end
end
