defmodule CockroachLiveview.Chat.MessageReaction do
  alias CockroachLiveview.Auth.User
  alias CockroachLiveview.Chat.{Message, Emoji}
  use Ecto.Schema
  import Ecto.Changeset

  schema "chat_message_reactions" do
    belongs_to :message, Message
    belongs_to :user, User
    belongs_to :emoji_id, Emoji

    timestamps()
  end

  @doc false
  def changeset(message_reaction, attrs) do
    message_reaction
    |> cast(attrs, [:message_id, :user_id, :emoji_id])
    |> validate_required([:message_id, :user_id, :emoji_id])
    |> unique_constraint(:emoji_id, 
      name: :chat_message_reactions_message_id_user_id_emoji_id_index )
  end
end
