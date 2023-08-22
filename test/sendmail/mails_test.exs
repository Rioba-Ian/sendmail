defmodule Sendmail.MailsTest do
  use Sendmail.DataCase

  alias Sendmail.Mails

  describe "mails" do
    alias Sendmail.Mails.Mail

    import Sendmail.MailsFixtures

    @invalid_attrs %{body: nil, subject: nil}

    test "list_mails/0 returns all mails" do
      mail = mail_fixture()
      assert Mails.list_mails() == [mail]
    end

    test "get_mail!/1 returns the mail with given id" do
      mail = mail_fixture()
      assert Mails.get_mail!(mail.id) == mail
    end

    test "create_mail/1 with valid data creates a mail" do
      valid_attrs = %{body: "some body", subject: "some subject"}

      assert {:ok, %Mail{} = mail} = Mails.create_mail(valid_attrs)
      assert mail.body == "some body"
      assert mail.subject == "some subject"
    end

    test "create_mail/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mails.create_mail(@invalid_attrs)
    end

    test "update_mail/2 with valid data updates the mail" do
      mail = mail_fixture()
      update_attrs = %{body: "some updated body", subject: "some updated subject"}

      assert {:ok, %Mail{} = mail} = Mails.update_mail(mail, update_attrs)
      assert mail.body == "some updated body"
      assert mail.subject == "some updated subject"
    end

    test "update_mail/2 with invalid data returns error changeset" do
      mail = mail_fixture()
      assert {:error, %Ecto.Changeset{}} = Mails.update_mail(mail, @invalid_attrs)
      assert mail == Mails.get_mail!(mail.id)
    end

    test "delete_mail/1 deletes the mail" do
      mail = mail_fixture()
      assert {:ok, %Mail{}} = Mails.delete_mail(mail)
      assert_raise Ecto.NoResultsError, fn -> Mails.get_mail!(mail.id) end
    end

    test "change_mail/1 returns a mail changeset" do
      mail = mail_fixture()
      assert %Ecto.Changeset{} = Mails.change_mail(mail)
    end
  end
end
