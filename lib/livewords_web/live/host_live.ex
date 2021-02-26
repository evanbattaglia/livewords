defmodule LivewordsWeb.HostLive do
  use LivewordsWeb, :live_view
  alias Livewords.Games

  @game_type :person # TODO

  defp topic(game_id), do: "game:#{game_id}"

  # TODO much is shared with PlayLive. extract.

  def clue_string(template, modifiers, nouns) do
    mod_string = modifiers |> Enum.reverse |> Enum.join(" ")
    noun_string = nouns |> Enum.reverse |> Enum.join(" ")

    :io_lib.format(template, [mod_string, noun_string])
    |> to_string
    |> String.replace("  ", " ")
  end

  def button_classes(word, used_words) do
    if Enum.member?(used_words, word), do: "used", else: "unused"
  end

  defp assign_new_palette(socket) do
    {template, modifiers, nouns} =
      Livewords.Corpus.new_palette(@game_type, 12, 12, socket.assigns.guesses)

    assign(
      socket,
      template: template, modifiers: modifiers, nouns: nouns,
      used_modifiers: [], used_nouns: []
    )
  end

  @impl true
  def mount(%{"game_id" => game_id}, _session, socket) do
    LivewordsWeb.Endpoint.subscribe(topic(game_id))

    assigns = [
      game_id: game_id,
      clues: Games.get_clues(game_id),
      guesses: Games.get_guesses(game_id),
    ]

    {:ok, socket |> assign(assigns) |> assign_new_palette}
  end

  @impl true
  def handle_event("new_clue", %{"text" => text}, socket) do
    game_id = socket.assigns.game_id
    Games.create_clue(game_id, text)
    LivewordsWeb.Endpoint.broadcast_from(self(), topic(game_id), "update_clues", nil)
      
    {:noreply, socket |> assign_new_palette |> assign(clues: Games.get_clues(game_id))}
  end

  @impl true
  def handle_event("skip", _, socket) do
    {:noreply, assign_new_palette(socket)}
  end

  defp add_or_remove(list, word) do
    if Enum.member?(list, word) do
      List.delete(list, word)
    else
      [ word | list]
    end
  end

  @impl true
  def handle_event("noun", %{"word" => word}, socket) do
    new_used_nouns = add_or_remove(socket.assigns.used_nouns, word)
    {:noreply, assign(socket, used_nouns: new_used_nouns)}
  end

  @impl true
  def handle_event("modifier", %{"word" => word}, socket) do
    new_used_modifiers = add_or_remove(socket.assigns.used_modifiers, word)
    {:noreply, assign(socket, used_modifiers: new_used_modifiers)}
  end

  @impl true
  def handle_info(%{event: "update_guesses"}, socket) do
    {:noreply, assign(socket, guesses: Games.get_guesses(socket.assigns.game_id))}
  end

  @impl true
  def handle_info(%{event: "update_clues"}, socket) do
    {:noreply, assign(socket, clues: Games.get_clues(socket.assigns.game_id))}
  end
end
