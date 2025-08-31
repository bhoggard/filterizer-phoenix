defmodule FilterizerWeb.NeighborhoodLive.Form do
  use FilterizerWeb, :live_view

  alias Filterizer.Neighborhoods
  alias Filterizer.Neighborhoods.Neighborhood

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage neighborhood records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="neighborhood-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:name]} type="text" label="Name" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Neighborhood</.button>
          <.button navigate={return_path(@return_to, @neighborhood)}>Cancel</.button>
        </footer>
      </.form>
    </Layouts.app>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(:return_to, return_to(params["return_to"]))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp return_to("show"), do: "show"
  defp return_to(_), do: "index"

  defp apply_action(socket, :edit, %{"id" => id}) do
    neighborhood = Neighborhoods.get_neighborhood!(id)

    socket
    |> assign(:page_title, "Edit Neighborhood")
    |> assign(:neighborhood, neighborhood)
    |> assign(:form, to_form(Neighborhoods.change_neighborhood(neighborhood)))
  end

  defp apply_action(socket, :new, _params) do
    neighborhood = %Neighborhood{}

    socket
    |> assign(:page_title, "New Neighborhood")
    |> assign(:neighborhood, neighborhood)
    |> assign(:form, to_form(Neighborhoods.change_neighborhood(neighborhood)))
  end

  @impl true
  def handle_event("validate", %{"neighborhood" => neighborhood_params}, socket) do
    changeset = Neighborhoods.change_neighborhood(socket.assigns.neighborhood, neighborhood_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"neighborhood" => neighborhood_params}, socket) do
    save_neighborhood(socket, socket.assigns.live_action, neighborhood_params)
  end

  defp save_neighborhood(socket, :edit, neighborhood_params) do
    case Neighborhoods.update_neighborhood(socket.assigns.neighborhood, neighborhood_params) do
      {:ok, neighborhood} ->
        {:noreply,
         socket
         |> put_flash(:info, "Neighborhood updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, neighborhood))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_neighborhood(socket, :new, neighborhood_params) do
    case Neighborhoods.create_neighborhood(neighborhood_params) do
      {:ok, neighborhood} ->
        {:noreply,
         socket
         |> put_flash(:info, "Neighborhood created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, neighborhood))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _neighborhood), do: ~p"/neighborhoods"
  defp return_path("show", neighborhood), do: ~p"/neighborhoods/#{neighborhood}"
end
