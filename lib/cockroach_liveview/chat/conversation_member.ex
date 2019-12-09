defmodule CockroachLiveview.Chat.ConversationMember do
  alias CockroachLiveview.Auth.User
  alias CockroachLiveview.Chat.Conversation
  use Ecto.Schema
  import Ecto.Changeset

  schema "chat_conversation_members" do
    field :owner, :boolean, default: false
    belongs_to :conversation, Conversation
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(conversation_member, attrs) do
    conversation_member
    |> cast(attrs, [:owner, :conversation_id, :user_id])
    |> validate_required([:owner, :conversation_id, :user_id])
    |> unique_constraint(:user, name: :chat_conversation_members_conversation_id_user_id_index)
  end
end
