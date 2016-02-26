defmodule Dinero.DebitControllerTest do
  use Dinero.ConnCase

  alias Dinero.Debit
  @valid_attrs %{insurance: true, max_age: 42, name: "some content", opening: 42, promo: true, requirements: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, debit_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing debits"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, debit_path(conn, :new)
    assert html_response(conn, 200) =~ "New debit"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, debit_path(conn, :create), debit: @valid_attrs
    assert redirected_to(conn) == debit_path(conn, :index)
    assert Repo.get_by(Debit, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, debit_path(conn, :create), debit: @invalid_attrs
    assert html_response(conn, 200) =~ "New debit"
  end

  test "shows chosen resource", %{conn: conn} do
    debit = Repo.insert! %Debit{}
    conn = get conn, debit_path(conn, :show, debit)
    assert html_response(conn, 200) =~ "Show debit"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, debit_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    debit = Repo.insert! %Debit{}
    conn = get conn, debit_path(conn, :edit, debit)
    assert html_response(conn, 200) =~ "Edit debit"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    debit = Repo.insert! %Debit{}
    conn = put conn, debit_path(conn, :update, debit), debit: @valid_attrs
    assert redirected_to(conn) == debit_path(conn, :show, debit)
    assert Repo.get_by(Debit, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    debit = Repo.insert! %Debit{}
    conn = put conn, debit_path(conn, :update, debit), debit: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit debit"
  end

  test "deletes chosen resource", %{conn: conn} do
    debit = Repo.insert! %Debit{}
    conn = delete conn, debit_path(conn, :delete, debit)
    assert redirected_to(conn) == debit_path(conn, :index)
    refute Repo.get(Debit, debit.id)
  end
end
