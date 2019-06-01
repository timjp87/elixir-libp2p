defmodule Libp2p.IpcClient do
  @moduledoc """
  Dispatches calls to the IpcServer.
  """
  alias Libp2p.IpcServer
  @timeout 60_000
  def post_request(payload) do
    with {:ok, response} <- call_ipc(payload) do
      decoded_body = P2pd.Pb.Response.decode(response)

      # TODO: Rework error handling
      case decoded_body.type do
        0 -> decoded_body
        _ -> {:error, decoded_body.errorrespons}
      end
    else
      {:error, error} -> {:error, error}
    end
  end

  defp call_ipc(payload) do
    :poolboy.transaction(:ipc_worker, fn pid -> IpcServer.post(pid, payload) end, @timeout)
  end
end
