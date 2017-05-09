defmodule Quest.Web.OptionControllerTest do
  use Quest.Web.ConnCase

  alias Quest.Main

  @create_attrs %{order: 42, title: "some title"}
  @update_attrs %{order: 43, title: "some updated title"}
  @invalid_attrs %{order: nil, title: nil}

  def fixture(:option) do
    {:ok, option} = Main.create_option(@create_attrs)
    option
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, option_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Options"
  end

  test "renders form for new options", %{conn: conn} do
    conn = get conn, option_path(conn, :new)
    assert html_response(conn, 200) =~ "New Option"
  end

  test "creates option and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, option_path(conn, :create), option: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == option_path(conn, :show, id)

    conn = get conn, option_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Option"
  end

  test "does not create option and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, option_path(conn, :create), option: @invalid_attrs
    assert html_response(conn, 200) =~ "New Option"
  end

  test "renders form for editing chosen option", %{conn: conn} do
    option = fixture(:option)
    conn = get conn, option_path(conn, :edit, option)
    assert html_response(conn, 200) =~ "Edit Option"
  end

  test "updates chosen option and redirects when data is valid", %{conn: conn} do
    option = fixture(:option)
    conn = put conn, option_path(conn, :update, option), option: @update_attrs
    assert redirected_to(conn) == option_path(conn, :show, option)

    conn = get conn, option_path(conn, :show, option)
    assert html_response(conn, 200) =~ "some updated title"
  end

  test "does not update chosen option and renders errors when data is invalid", %{conn: conn} do
    option = fixture(:option)
    conn = put conn, option_path(conn, :update, option), option: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Option"
  end

  test "deletes chosen option", %{conn: conn} do
    option = fixture(:option)
    conn = delete conn, option_path(conn, :delete, option)
    assert redirected_to(conn) == option_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, option_path(conn, :show, option)
    end
  end
end
