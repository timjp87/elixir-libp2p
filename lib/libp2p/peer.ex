defmodule Libp2p.Peer do
  @moduledoc """
  Functions related to peer connection and streaming.
  """
  alias Libp2p.{IpcClient, Serialize}
  alias P2pd.Pb.{Request, DisconnectRequest, ConnectRequest}

  @doc """
  Clients issue an Identify request when they wish to determine the peer ID and listen addresses of the daemon.
  """
  def identify do
    Request.new(type: Request.Type.value(:IDENTIFY))
    |> Serialize.serialize()
    |> IpcClient.post_request()
  end

  @doc """
  Clients issue a Connect request when they wish to connect to a known peer on a given set of addresses.
  """
  def connect(peer, addr, timeout \\ 2) do
    peer = from_string(peer)

    addr =
      addr
      |> String.to_charlist()
      |> :multiaddr.new()

    addrs = List.insert_at([], 0, addr)
    connect_request = ConnectRequest.new(peer: peer, addrs: addrs, timeout: timeout)

    Request.new(type: Request.Type.value(:CONNECT), connect: connect_request)
    |> Serialize.serialize()
    |> IpcClient.post_request()
  end

  @doc """
  Clients issue a Disconnect request when they wish to disconnect from a peer.
  """
  def disconnect(peer) do
    peer = from_string(peer)
    disconnect_request = DisconnectRequest.new(peer: peer)

    Request.new(type: Request.Type.value(:DISCONNECT), disconnect: disconnect_request)
    |> Serialize.serialize()
    |> IpcClient.post_request()
  end

  @doc """
  List all peers that the daemon is connected to.
  """
  def list_peers do
    Request.new(type: Request.Type.value(:LIST_PEERS))
    |> Serialize.serialize()
    |> IpcClient.post_request()
  end

  @doc """
  Turns peer id binary to string representation.
  """
  def to_string(bytes) do
    B58.encode58(bytes)
  end

  @doc """
  Turns peer id into a binary representation.
  """
  def from_string(string) do
    B58.decode58!(string)
  end
end
