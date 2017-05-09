defmodule Quest.MainTest do
  use Quest.DataCase

  alias Quest.Main
  alias Quest.Main.Questionnaire

  @create_attrs %{info: "some info", status: "some status", tags: [], title: "some title"}
  @update_attrs %{info: "some updated info", status: "some updated status", tags: [], title: "some updated title"}
  @invalid_attrs %{info: nil, status: nil, tags: nil, title: nil}

  def fixture(:questionnaire, attrs \\ @create_attrs) do
    {:ok, questionnaire} = Main.create_questionnaire(attrs)
    questionnaire
  end

  test "list_questionnaires/1 returns all questionnaires" do
    questionnaire = fixture(:questionnaire)
    assert Main.list_questionnaires() == [questionnaire]
  end

  test "get_questionnaire! returns the questionnaire with given id" do
    questionnaire = fixture(:questionnaire)
    assert Main.get_questionnaire!(questionnaire.id) == questionnaire
  end

  test "create_questionnaire/1 with valid data creates a questionnaire" do
    assert {:ok, %Questionnaire{} = questionnaire} = Main.create_questionnaire(@create_attrs)
    assert questionnaire.info == "some info"
    assert questionnaire.status == "some status"
    assert questionnaire.tags == []
    assert questionnaire.title == "some title"
  end

  test "create_questionnaire/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Main.create_questionnaire(@invalid_attrs)
  end

  test "update_questionnaire/2 with valid data updates the questionnaire" do
    questionnaire = fixture(:questionnaire)
    assert {:ok, questionnaire} = Main.update_questionnaire(questionnaire, @update_attrs)
    assert %Questionnaire{} = questionnaire
    assert questionnaire.info == "some updated info"
    assert questionnaire.status == "some updated status"
    assert questionnaire.tags == []
    assert questionnaire.title == "some updated title"
  end

  test "update_questionnaire/2 with invalid data returns error changeset" do
    questionnaire = fixture(:questionnaire)
    assert {:error, %Ecto.Changeset{}} = Main.update_questionnaire(questionnaire, @invalid_attrs)
    assert questionnaire == Main.get_questionnaire!(questionnaire.id)
  end

  test "delete_questionnaire/1 deletes the questionnaire" do
    questionnaire = fixture(:questionnaire)
    assert {:ok, %Questionnaire{}} = Main.delete_questionnaire(questionnaire)
    assert_raise Ecto.NoResultsError, fn -> Main.get_questionnaire!(questionnaire.id) end
  end

  test "change_questionnaire/1 returns a questionnaire changeset" do
    questionnaire = fixture(:questionnaire)
    assert %Ecto.Changeset{} = Main.change_questionnaire(questionnaire)
  end
end
