defmodule FilterizerWeb.NeighborhoodLiveTest do
  use FilterizerWeb.ConnCase

  import Phoenix.LiveViewTest
  import Filterizer.NeighborhoodsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}
  defp create_neighborhood(_) do
    neighborhood = neighborhood_fixture()

    %{neighborhood: neighborhood}
  end

  describe "Index" do
    setup [:create_neighborhood]

    test "lists all neighborhoods without auth returns 401", %{conn: conn} do
      conn = get(conn, ~p"/neighborhoods")
      assert conn.status == 401
    end

    test "lists all neighborhoods", %{conn: conn, neighborhood: neighborhood} do
      conn =
        conn
        |> with_valid_authorization_header()

      {:ok, _index_live, html} = live(conn, ~p"/neighborhoods")

      assert html =~ "Listing Neighborhoods"
      assert html =~ neighborhood.name
    end

    test "saves new neighborhood", %{conn: conn} do
      conn =
        conn
        |> with_valid_authorization_header()

      {:ok, index_live, _html} = live(conn, ~p"/neighborhoods")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Neighborhood")
               |> render_click()
               |> follow_redirect(conn, ~p"/neighborhoods/new")

      assert render(form_live) =~ "New Neighborhood"

      assert form_live
             |> form("#neighborhood-form", neighborhood: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#neighborhood-form", neighborhood: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/neighborhoods")

      html = render(index_live)
      assert html =~ "Neighborhood created successfully"
      assert html =~ "some name"
    end

    test "updates neighborhood in listing", %{conn: conn, neighborhood: neighborhood} do
      conn =
        conn
        |> with_valid_authorization_header()

      {:ok, index_live, _html} = live(conn, ~p"/neighborhoods")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#neighborhoods-#{neighborhood.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/neighborhoods/#{neighborhood}/edit")

      assert render(form_live) =~ "Edit Neighborhood"

      assert form_live
             |> form("#neighborhood-form", neighborhood: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#neighborhood-form", neighborhood: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/neighborhoods")

      html = render(index_live)
      assert html =~ "Neighborhood updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes neighborhood in listing", %{conn: conn, neighborhood: neighborhood} do
      conn =
        conn
        |> with_valid_authorization_header()

      {:ok, index_live, _html} = live(conn, ~p"/neighborhoods")

      assert index_live
             |> element("#neighborhoods-#{neighborhood.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#neighborhoods-#{neighborhood.id}")
    end
  end
end
