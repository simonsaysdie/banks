defmodule Dinero.PageController do
  use Dinero.Web, :controller
  alias Dinero.Bank

  def index(conn, _params) do
    banks = Bank.map_with_id
    render conn, "index.html", banks: banks
  end
end
