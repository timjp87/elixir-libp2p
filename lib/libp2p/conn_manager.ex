defmodule Libp2p.ConnectionManager do
  @moduledoc """
  Functions to handle open connections such as tagging and trimming.
  """
  alias Libp2p.{IpcClient, Peer, Serialize}
  alias P2pd.Pb.{Request, ConnManagerRequest}

  @doc """
  Tag a peer with a label and weight.
  """
  def tag_peer(peer, tag, weight) do
    peer = Peer.from_string(peer)

    connmanager_request =
      ConnManagerRequest.new(
        type: ConnManagerRequest.Type.value(:TAG_PEER),
        peer: peer,
        tag: tag,
        weight: weight
      )

    Request.new(type: Request.Type.value(:CONNMANAGER), connManager: connmanager_request)
    |> Serialize.serialize()
    |> IpcClient.post_request()
  end

  @doc """
  Remove tag from a peer.
  """
  def untag_peer(peer, tag) do
    peer = Peer.from_string(peer)

    connmanager_request =
      ConnManagerRequest.new(
        type: ConnManagerRequest.Type.value(:UNTAG_PEER),
        peer: peer,
        tag: tag
      )

    Request.new(type: Request.Type.value(:CONNMANAGER), connManager: connmanager_request)
    |> Serialize.serialize()
    |> IpcClient.post_request()
  end

  @doc """
  Clients can issue a TRIM request to trim open connections.
  """
  def trim do
    connmanager_request = ConnManagerRequest.new(type: ConnManagerRequest.Type.value(:TRIM))

    Request.new(type: Request.Type.value(:CONNMANAGER), connManager: connmanager_request)
    |> Serialize.serialize()
    |> IpcClient.post_request()
  end
end
