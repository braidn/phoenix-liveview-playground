defmodule CockroachLiveview.Chat.Message do
  alias CockroachLiveview.Auth.User
  alias CockroachLiveview.Chat.{Conversation, SeenMessage, MessageReaction}

  use Ecto.Schema
  import Ecto.Changeset

  schema "chat_messages" do
    field :content, :string

    belongs_to :conversation, Conversation
    belongs_to :user, User

    has_many :seen_messages, SeenMessage
    has_many :message_reactions, MessageReaction

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
