defmodule Discuss.Comment do
  use Discuss.Web, :model

  # the only thing that poison needs to convert to json formant
  # this has to be related to Discuss.CommentsChannel last line of join method
  @derive {Poison.Encoder, only: [:content, :user]}

  schema "comments" do
    field(:content, :string)
    belongs_to(:user, Discuss.User)
    belongs_to(:topic, Discuss.Topic)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
