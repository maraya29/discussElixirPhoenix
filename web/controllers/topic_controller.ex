defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic

  plug(Discuss.Plugs.RequiredAuth when action in [:new, :create, :edit, :update, :delete])

  plug(:check_topic_owner when action in [:update, :edit, :delete])

  # add _ to params to remove the warning if we are not using the variable
  def index(conn, _params) do
    # IO.puts("**********conn")
    # IO.inspect(conn)
    topics = Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end

  def show(conn, %{"id" => topic_id}) do
    topic = Repo.get!(Topic, topic_id)
    render(conn, "show.html", topic: topic)
  end

  def new(conn, params) do
    # IO.puts("**********conn")
    # IO.inspect(conn)
    # IO.puts("**********params")
    # IO.inspect(params)

    # struct = %Discuss.Topic{}
    # because of the alias
    # struct = %Topic{}
    # params = %{}
    # changeset = Discuss.Topic.changeset(struct, params)
    # because of the alias
    changeset = Topic.changeset(%Topic{}, params)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    # next line change to 37 because of user relation
    # changeset = Topic.changeset(%Topic{}, topic)
    # IO.puts("**********changeset")
    # IO.inspect(changeset)
    changeset =
      conn.assigns.user
      |> build_assoc(:topics)
      |> Topic.changeset(topic)

    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: topic_path(conn, :index))

      {:error, changeset} ->
        render(
          conn
          |> put_flash(:error, "Error Creating Topic"),
          "new.html",
          changeset: changeset
        )
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)
    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)
    # two above same as... result of line 59 pass as 1 parameter in line 60
    # changeset =
    #   Repo.get(Topic, topic_id)
    #   |> Topic.changeset(topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: topic_path(conn, :index))

      {:error, changeset} ->
        render(
          conn
          |> put_flash(:error, "Error Updating Topic"),
          "edit.html",
          changeset: changeset,
          topic: old_topic
        )
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id)
    |> Repo.delete!()

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: topic_path(conn, :index))
  end

  def check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn

    if Repo.get(Topic, topic_id).user_id == conn.assigns.user.id do
      # if return conn everything is ok please go on
      conn
    else
      # halt() says phoenix we are done please dont do
      # anything else just send the response back to the user
      conn
      |> put_flash(:error, "You cannot edit that...")
      |> redirect(to: topic_path(conn, :index))
      |> halt()
    end
  end
end
