defmodule SendmailWeb.AdminUserLive do
  use SendmailWeb, :live_view

  alias Sendmail.Accounts

  def mount(_params, _session, socket) do
    # Fetch all users
    users = Sendmail.Accounts.list_users()
    {:ok, assign(socket, users: users)}
  end

  def render(assigns) do
    ~L"""
    <h1>All Users</h1>

    <%= for user <- @users do %>
      <p><%= user.email %></p>
    <% end %>
    """
  end

  def handle_event("make_admin", %{"user_id" => id}, socket) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.make_admin(user)

    {:noreply, socket}
  end

  def handle_event("revoke_admin", %{"user_id" => id}, socket) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.revoke_admin(user)

    {:noreply, socket}
  end
end
