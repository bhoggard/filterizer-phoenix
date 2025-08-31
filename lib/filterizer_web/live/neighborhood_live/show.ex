defmodule FilterizerWeb.NeighborhoodLive.Show do
  use FilterizerWeb, :live_view

  alias Filterizer.Neighborhoods

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Neighborhood {@neighborhood.id}
        <:subtitle>This is a neighborhood record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/neighborhoods"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/neighborhoods/#{@neighborhood}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit neighborhood
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Name">{@neighborhood.name}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Neighborhood")
     |> assign(:neighborhood, Neighborhoods.get_neighborhood!(id))}
  end
end
