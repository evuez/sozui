defmodule SozUIWeb.PageController do
  use SozUIWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
