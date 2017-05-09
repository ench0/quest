defmodule Quest.StaticTest do
  use Quest.DataCase

  alias Quest.Static
  alias Quest.Static.Page

  @create_attrs %{active: true, body: "some body", menu: true, slug: "some slug", title: "some title"}
  @update_attrs %{active: false, body: "some updated body", menu: false, slug: "some updated slug", title: "some updated title"}
  @invalid_attrs %{active: nil, body: nil, menu: nil, slug: nil, title: nil}

  def fixture(:page, attrs \\ @create_attrs) do
    {:ok, page} = Static.create_page(attrs)
    page
  end

  test "list_pages/1 returns all pages" do
    page = fixture(:page)
    assert Static.list_pages() == [page]
  end

  test "get_page! returns the page with given id" do
    page = fixture(:page)
    assert Static.get_page!(page.id) == page
  end

  test "create_page/1 with valid data creates a page" do
    assert {:ok, %Page{} = page} = Static.create_page(@create_attrs)
    assert page.active == true
    assert page.body == "some body"
    assert page.menu == true
    assert page.slug == "some slug"
    assert page.title == "some title"
  end

  test "create_page/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Static.create_page(@invalid_attrs)
  end

  test "update_page/2 with valid data updates the page" do
    page = fixture(:page)
    assert {:ok, page} = Static.update_page(page, @update_attrs)
    assert %Page{} = page
    assert page.active == false
    assert page.body == "some updated body"
    assert page.menu == false
    assert page.slug == "some updated slug"
    assert page.title == "some updated title"
  end

  test "update_page/2 with invalid data returns error changeset" do
    page = fixture(:page)
    assert {:error, %Ecto.Changeset{}} = Static.update_page(page, @invalid_attrs)
    assert page == Static.get_page!(page.id)
  end

  test "delete_page/1 deletes the page" do
    page = fixture(:page)
    assert {:ok, %Page{}} = Static.delete_page(page)
    assert_raise Ecto.NoResultsError, fn -> Static.get_page!(page.id) end
  end

  test "change_page/1 returns a page changeset" do
    page = fixture(:page)
    assert %Ecto.Changeset{} = Static.change_page(page)
  end
end
