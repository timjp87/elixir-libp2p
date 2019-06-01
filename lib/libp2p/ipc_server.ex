defmodule Libp2p.IpcServer do
  use GenServer

  def init(state) do
    opts = [:binary, active: false, reuseaddr: true]
    response = :gen_tcp.connect({:local, Application.get_env(:libp2p, :ipc_path)}, 0, opts)

    case response do
      {:ok, socket} -> {:ok, Keyword.put(state, :socket, socket)}
      {:error, reason} -> {:error, reason}
    end
  end

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, Keyword.merge(state, socket: nil))
  end

  def post(pid, request) do
    GenServer.call(pid, {:request, request})
  end

  defp receive_response(:ok, socket, timeout) do
    {:ok, length} = :gen_tcp.recv(socket, 1, timeout)
    :gen_tcp.recv(socket, :binary.decode_unsigned(length), timeout)
  end

  def handle_call(
        {:request, request},
        _from,
        [socket: socket, path: _, ipc_request_timeout: timeout] = state
      ) do
    response =
      socket
      |> :gen_tcp.send(request)
      |> receive_response(socket, timeout)

    {:reply, response, state}
  end
end
