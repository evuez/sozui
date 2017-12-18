defmodule SozUIWeb.SozuChannel do
  use SozUIWeb, :channel

  require Logger

  alias ExSozu.Answer
  alias ExSozu.Command
  alias Phoenix.Socket

  def join("sozu:lobby", _payload, socket) do
    {:ok, socket}
  end

  def handle_in("command:workers", _payload, socket) do
    {:ok, id} = Command.list_workers() |> ExSozu.command()
    {:reply, :ok, assign(socket, :command, id)}
  end
  def handle_in("command:status", _payload, socket) do
    {:ok, id} = Command.status() |> ExSozu.command()
    {:reply, :ok, assign(socket, :command, id)}
  end
  def handle_in("command:upgrade-master", _payload, socket) do
    {:ok, id} = Command.upgrade_master() |> ExSozu.command()
    {:reply, :ok, assign(socket, :command, id)}
  end
  def handle_in("command:soft-stop", _payload, socket) do
    {:ok, id} = Command.soft_stop() |> ExSozu.command()
    {:reply, :ok, assign(socket, :command, id)}
  end
  def handle_in("command:dump-state", _payload, socket) do
    {:ok, id} = Command.dump_state() |> ExSozu.command()
    {:reply, :ok, assign(socket, :command, id)}
  end

  def handle_info({:answer,
                   answer = %Answer{id: id}},
                   socket = %Socket{assigns: %{command: id}}) do
    push socket, "answer", answer

    {:noreply, socket}
  end
  # If `answer.id` doesn't match `socket.assigns.command` if means that `answer` isn't
  # the last requested answer.
  def handle_info({:answer, answer}, socket) do
    Logger.warn "Ignoring delayed answer #{inspect answer}"

    {:noreply, socket}
  end
end
