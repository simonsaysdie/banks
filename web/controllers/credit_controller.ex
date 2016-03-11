defmodule Dinero.CreditController do
  use Dinero.Web, :controller

  alias Dinero.Credit
  alias Dinero.Bank

  plug :scrub_params, "credit" when action in [:create, :update]

  def index(conn, _params) do
    credits = Repo.all(Credit)
    render(conn, "index.html", credits: credits)
  end

  def public_index(conn, _params) do
    credits = Credit.all_with_banks
    render(conn, "public_index.html", credits: credits)
  end

  def new(conn, _params) do
    changeset = Credit.changeset(%Credit{})
    banks = Bank.map_with_id
    render(conn, "new.html", changeset: changeset, banks: banks)
  end

  def create(conn, %{"credit" => credit_params}) do
    changeset = Credit.changeset(%Credit{}, credit_params)

    case Repo.insert(changeset) do
      {:ok, _credit} ->
        conn
        |> put_flash(:info, "Credit created successfully.")
        |> redirect(to: credit_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    credit = Repo.get!(Credit, id)
    render(conn, "show.html", credit: credit)
  end

  def edit(conn, %{"id" => id}) do
    credit = Repo.get!(Credit, id)
    changeset = Credit.changeset(credit)
    banks = Bank.map_with_id
    render(conn, "edit.html", credit: credit, changeset: changeset, banks: banks)
  end

  def update(conn, %{"id" => id, "credit" => credit_params}) do
    credit = Repo.get!(Credit, id)
    changeset = Credit.changeset(credit, credit_params)

    case Repo.update(changeset) do
      {:ok, credit} ->
        conn
        |> put_flash(:info, "Credit updated successfully.")
        |> redirect(to: credit_path(conn, :show, credit))
      {:error, changeset} ->
        render(conn, "edit.html", credit: credit, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    credit = Repo.get!(Credit, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(credit)

    conn
    |> put_flash(:info, "Credit deleted successfully.")
    |> redirect(to: credit_path(conn, :index))
  end
end
