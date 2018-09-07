defmodule Discuss.Plugs.SetUser do
  # helpers to work with conn object
  import Plug.Conn
  # for session handler
  import Phoenix.Controller

  alias Discuss.Repo
  alias Discuss.User

  def init(_params) do
  end

  # _params comes from init function in this case is nil because tehre is no data on init function
  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    cond do
      # add user to conn
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user)

      true ->
        assign(conn, :user, nil)
    end
  end
end
