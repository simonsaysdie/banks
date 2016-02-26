defmodule Dinero.PageController do
  use Dinero.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
