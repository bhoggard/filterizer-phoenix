defmodule FilterizerWeb.PageController do
  use FilterizerWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
