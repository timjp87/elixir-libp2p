defmodule Libp2p do
  use Application
  @moduledoc File.read!("#{__DIR__}/../README.md")
  import Supervisor.Spec, warn: false

  def start(_type, _args) do
    children = setup_children()
    opts = [strategy: :one_for_one, name: Libp2p.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp setup_children() do
    path = ipc_path()

    [
      :poolboy.child_spec(:worker, poolboy_config(),
        path: path,
        ipc_request_timeout: ipc_request_timeout()
      )
    ]
  end

  defp poolboy_config() do
    [
      {:name, {:local, :ipc_worker}},
      {:worker_module, Libp2p.IpcServer},
      {:size, ipc_worker_size()},
      {:max_overflow, ipc_max_worker_overflow()}
    ]
  end

  @spec ipc_path() :: binary()
  defp ipc_path do
    case Application.get_env(:libp2p, :ipc_path, "") do
      path when is_binary(path) and path != "" ->
        path

      not_a_path ->
        raise ArgumentError,
          message:
            "Please set config variable `config :libp2p, :ipc_path, \"path/to/ipc\"` got #{
              not_a_path
            }"
    end
  end

  defp ipc_worker_size() do
    Application.get_env(:libp2p, :ipc_worker_size, 5)
  end

  defp ipc_max_worker_overflow() do
    Application.get_env(:libp2p, :ipc_max_worker_overflow, 2)
  end

  defp ipc_request_timeout() do
    Application.get_env(:libp2p, :ipc_request_timeout, 60_000)
  end
end
