defmodule SendmailWeb.MailControllerTest do
  use SendmailWeb.ConnCase

  import Sendmail.MailsFixtures

  @create_attrs %{body: "some body", subject: "some subject"}
  @update_attrs %{body: "some updated body", subject: "some updated subject"}
  @invalid_attrs %{body: nil, subject: nil}

  describe "index" do
    test "lists all mails", %{conn: conn} do
      conn = get(conn, ~p"/mails")
      assert html_response(conn, 200) =~ "Listing Mails"
    end
  end

  describe "new mail" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/mails/new")
      assert html_response(conn, 200) =~ "New Mail"
    end
  end

  describe "create mail" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/mails", mail: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/mails/#{id}"

      conn = get(conn, ~p"/mails/#{id}")
      assert html_response(conn, 200) =~ "Mail #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/mails", mail: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Mail"
    end
  end

  describe "edit mail" do
    setup [:create_mail]

    test "renders form for editing chosen mail", %{conn: conn, mail: mail} do
      conn = get(conn, ~p"/mails/#{mail}/edit")
      assert html_response(conn, 200) =~ "Edit Mail"
    end
  end

  describe "update mail" do
    setup [:create_mail]

    test "redirects when data is valid", %{conn: conn, mail: mail} do
      conn = put(conn, ~p"/mails/#{mail}", mail: @update_attrs)
      assert redirected_to(conn) == ~p"/mails/#{mail}"

      conn = get(conn, ~p"/mails/#{mail}")
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, mail: mail} do
      conn = put(conn, ~p"/mails/#{mail}", mail: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Mail"
    end
  end

  describe "delete mail" do
    setup [:create_mail]

    test "deletes chosen mail", %{conn: conn, mail: mail} do
      conn = delete(conn, ~p"/mails/#{mail}")
      assert redirected_to(conn) == ~p"/mails"

      assert_error_sent 404, fn ->
        get(conn, ~p"/mails/#{mail}")
      end
    end
  end

  defp create_mail(_) do
    mail = mail_fixture()
    %{mail: mail}
  end
end
