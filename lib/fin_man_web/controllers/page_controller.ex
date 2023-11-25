defmodule FinManWeb.PageController do
  use FinManWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
