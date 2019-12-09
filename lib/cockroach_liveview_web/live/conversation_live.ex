defmodule CockroachLiveview.ConversationLive do
  use Phoenix.LiveView
  use Phoenix.HTML

  alias CockroachLiveview.{Auth, Chat, Repo}

  def render(assigns) do
    ~L"""
    <div>
      <b>User name:</b> <%= @user.nickname %>
    </div>
    <div>
      <b>Conversation title:</b> <%= @conversation.title %>
    </div>
    <div>
      <%= f = form_for :message, "#", [phx_submit: "send_message"] %>
        <%= label f, :content %>
        <%= text_input f, :content %>
        <%= submit "Send" %>
      </form>
    </div>
    <div>
      <b>Messages:</b>
      <%= for message <- @messages do %>
        <div>
          <b><%= message.user.nickname %></b>: <%= message.content %>
        </div>
      <% end %>
    </div>
    """
  end

  def mount(_assigns, socket) do
    {:ok, socket}
  end

  def handle_event(
    "send_message",
    %{"message" => %{"content" => content}},
    %{assigns: %{conversation_id: conversation_id, users_id: users_id, user: user}} = socket
  ) do
    case Chat.create_message(%{
      conversation_id: conversation_id,
      user_id: users_id,
      content: content
    }) do
      {:ok, new_message} ->
        new_message = %{new_message | user: user}
        updated = socket.assigns[:message] ++ [new_message]

        {:noreply, socket |> assign(:messages, updated)}
      
      {:error, _} ->
        {:noreply, socket}
    end
  end

  def handle_params(%{"conversation_id" => conversation_id, "users_id" => user_id}, _ui, socket) do
    {:noreply,
      socket
      |>assign(:user_id, user_id)
      |>assign(:conversation_id, conversation_id)
      |>assign_records()}
  end

  defp assign_records(%{assigns: %{user_id: user_id, conversation_id: conversation_id}} = socket) do
    user = Auth.get_user!(user_id)

    conversation = Chat.get_conversation!(conversation_id)
                   |>Repo.preload(messages: [:user], conversation_members: [:user])

    socket
    |>assign(:user, user)
    |>assign(:conversation, conversation)
    |>assign(:messages, conversation.messages)
  end
end
