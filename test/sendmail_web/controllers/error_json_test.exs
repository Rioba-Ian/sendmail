defmodule SendmailWeb.ErrorJSONTest do
  use SendmailWeb.ConnCase, async: true

  test "renders 404" do
    assert SendmailWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert SendmailWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
