defmodule FinManWeb.PageController do
  use FinManWeb, :controller

  def index(conn, _params) do
    resp(conn, :ok, "")
  end
end
