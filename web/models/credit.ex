defmodule Dinero.Credit do
  use Dinero.Web, :model

  alias Dinero.Repo

  schema "credits" do
    belongs_to :bank, Dinero.Bank
    field :name, :string
    field :requirements, :string, default: "Identificación oficial, comprobante de domicilio, comprobante de ingresos"
    field :min_age, :integer, default: 18
    field :max_age, :integer, default: 0
    field :promo, :boolean, default: true
    field :insurance, :boolean, default: true 
    field :cat, :float
    field :annual, :integer
    field :additional_cards, :boolean, default: false
    field :min_income, :integer
    field :website, :string

    timestamps
  end

  @required_fields ~w(name requirements min_age max_age promo insurance cat annual additional_cards min_income bank_id website)
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
    query = from credit in Dinero.Credit, 
    preload: [:bank]

    Repo.all(query)  
  end

  def by_bank(bank_id) do
    query = from credit in Dinero.Credit,
    where: credit.bank_id == ^bank_id,
    preload: [:bank]

    Repo.all(query)
  end
end
