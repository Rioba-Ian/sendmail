defmodule SendmailWeb.AdminController do
  use SendmailWeb, :controller

  alias Sendmail.Accounts
  alias Sendmail.Repo

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully")
    |> redirect(to: "/admin/users")
  end

  def make_admin(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user, %{role: "admin"})

    case Repo.update(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User promoted to admin successfully")
        |> redirect(to: "/admin/users/#{id}")

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Failed to promote user to admin.")
        |> redirect(to: "/admin/users/#{id}")
    end
  end

  def revoke_admin(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user, %{role: "user"})

    case Repo.update(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Admin status revoked successfully.")
        |> redirect(to: "/admin/users/#{id}")

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Failed to revoke admin status.")
        |> redirect(to: "/admin/users/#{id}")
    end
  end
end
