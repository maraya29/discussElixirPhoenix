defmodule Discuss.Plugs.RequiredAuth do
  # helpers to work with conn object
  import Plug.Conn
  # for session handler
  import Phoenix.Controller

  # to know were we are.. this is not a controller with (use line) so I have to get acess via helpers to some methods
  alias Discuss.Router.Helpers

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns[:user] do
      # if return conn everything is ok please go on
      conn
    else
      # halt() says phoenix we are done please dont do
      # anything else just send the response back to the user
      conn
      |> put_flash(:error, "You must be logged in...")
      |> redirect(to: Helpers.topic_path(conn, :index))
      |> halt()
    end
  end
end
