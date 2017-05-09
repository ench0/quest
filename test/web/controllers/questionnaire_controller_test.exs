defmodule Quest.Web.QuestionnaireControllerTest do
  use Quest.Web.ConnCase

  alias Quest.Main

  @create_attrs %{info: "some info", status: "some status", tags: [], title: "some title"}
  @update_attrs %{info: "some updated info", status: "some updated status", tags: [], title: "some updated title"}
  @invalid_attrs %{info: nil, status: nil, tags: nil, title: nil}

  def fixture(:questionnaire) do
    {:ok, questionnaire} = Main.create_questionnaire(@create_attrs)
    questionnaire
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, questionnaire_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Questionnaires"
  end

  test "renders form for new questionnaires", %{conn: conn} do
    conn = get conn, questionnaire_path(conn, :new)
    assert html_response(conn, 200) =~ "New Questionnaire"
  end

  test "creates questionnaire and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, questionnaire_path(conn, :create), questionnaire: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == questionnaire_path(conn, :show, id)

    conn = get conn, questionnaire_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Questionnaire"
  end

  test "does not create questionnaire and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, questionnaire_path(conn, :create), questionnaire: @invalid_attrs
    assert html_response(conn, 200) =~ "New Questionnaire"
  end

  test "renders form for editing chosen questionnaire", %{conn: conn} do
    questionnaire = fixture(:questionnaire)
    conn = get conn, questionnaire_path(conn, :edit, questionnaire)
    assert html_response(conn, 200) =~ "Edit Questionnaire"
  end

  test "updates chosen questionnaire and redirects when data is valid", %{conn: conn} do
    questionnaire = fixture(:questionnaire)
    conn = put conn, questionnaire_path(conn, :update, questionnaire), questionnaire: @update_attrs
    assert redirected_to(conn) == questionnaire_path(conn, :show, questionnaire)

    conn = get conn, questionnaire_path(conn, :show, questionnaire)
    assert html_response(conn, 200) =~ "some updated info"
  end

  test "does not update chosen questionnaire and renders errors when data is invalid", %{conn: conn} do
    questionnaire = fixture(:questionnaire)
    conn = put conn, questionnaire_path(conn, :update, questionnaire), questionnaire: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Questionnaire"
  end

  test "deletes chosen questionnaire", %{conn: conn} do
    questionnaire = fixture(:questionnaire)
    conn = delete conn, questionnaire_path(conn, :delete, questionnaire)
    assert redirected_to(conn) == questionnaire_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, questionnaire_path(conn, :show, questionnaire)
    end
  end
end
