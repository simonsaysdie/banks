defmodule Dinero.BankControllerTest do
  use Dinero.ConnCase

  alias Dinero.Bank
  @valid_attrs %{name: "some content", website: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, bank_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing banks"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, bank_path(conn, :new)
    assert html_response(conn, 200) =~ "New bank"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, bank_path(conn, :create), bank: @valid_attrs
    assert redirected_to(conn) == bank_path(conn, :index)
    assert Repo.get_by(Bank, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, bank_path(conn, :create), bank: @invalid_attrs
    assert html_response(conn, 200) =~ "New bank"
  end

  test "shows chosen resource", %{conn: conn} do
    bank = Repo.insert! %Bank{}
    conn = get conn, bank_path(conn, :show, bank)
    assert html_response(conn, 200) =~ "Show bank"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, bank_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    bank = Repo.insert! %Bank{}
    conn = get conn, bank_path(conn, :edit, bank)
    assert html_response(conn, 200) =~ "Edit bank"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    bank = Repo.insert! %Bank{}
    conn = put conn, bank_path(conn, :update, bank), bank: @valid_attrs
    assert redirected_to(conn) == bank_path(conn, :show, bank)
    assert Repo.get_by(Bank, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    bank = Repo.insert! %Bank{}
    conn = put conn, bank_path(conn, :update, bank), bank: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit bank"
  end

  test "deletes chosen resource", %{conn: conn} do
    bank = Repo.insert! %Bank{}
    conn = delete conn, bank_path(conn, :delete, bank)
    assert redirected_to(conn) == bank_path(conn, :index)
    refute Repo.get(Bank, bank.id)
  end
end
