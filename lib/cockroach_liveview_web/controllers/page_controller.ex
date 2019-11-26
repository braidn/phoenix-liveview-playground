defmodule CockroachLiveviewWeb.PageController do
  use CockroachLiveviewWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
