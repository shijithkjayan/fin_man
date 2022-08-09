defmodule SanchayikaWeb.PageController do
  use SanchayikaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
