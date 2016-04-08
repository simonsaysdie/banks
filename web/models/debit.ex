defmodule Dinero.Debit do
  use Dinero.Web, :model

  alias Dinero.Repo

  schema "debits" do
    belongs_to :bank, Dinero.Bank
    field :name, :string
    field :website, :string
    field :requirements, :string, default: "Identificación oficial, comprobante de domicilio"
    field :opening, :integer
    field :max_age, :integer, default: 0
    field :min_age, :integer, default: 18
    field :promo, :boolean, default: true
    field :insurance, :boolean, default: true

    timestamps
  end

  @required_fields ~w(name requirements opening max_age min_age promo insurance bank_id website)
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

  def all_with_banks do
    query = from debit in Dinero.Debit, 
    preload: [:bank]

    Repo.all(query)  
  end

  def by_bank(bank_id) do
    query = from debit in Dinero.Debit,
    where: debit.bank_id == ^bank_id,
    preload: [:bank]

    Repo.all(query)
  end
end
