defmodule Dinero.Bank do
  use Dinero.Web, :model

  alias Dinero.Repo

  schema "banks" do
    has_many :credits, Dinero.Credit
    has_many :debits, Dinero.Debit
    field :name, :string
    field :website, :string

    timestamps
  end

  @required_fields ~w(name website)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def all_with_cards do
    query = from bank in Dinero.Bank, 
    preload: [:credits, :debits]

    Repo.all(query)
  end
end
