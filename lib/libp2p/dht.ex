defmodule Libp2p.DHT do
  @moduledoc """
  Functions for interacting with the Libp2p destributed hashtable.
  """
  alias Libp2p.{IpcClient, Peer, Serialize}
  alias P2pd.Pb.{Request, DHTRequest}

  @doc """
  Clients can issue a FIND_PEER request to query the DHT for a given peer's known addresses.
  """
  def find_peer(peer) do
    peer = Peer.from_string(peer)
    dht_request = DHTRequest.new(type: DHTRequest.Type.value(:FIND_PEER), peer: peer)

    Request.new(type: Request.Type.value(:DHT), dht: dht_request)
    |> Serialize.serialize()
    |> IpcClient.post_request()
  end

  @doc """
  Clients can issue a FIND_PEERS_CONNECTED_TO_PEER request to query the DHT for peers directly connected to a given peer in the DHT.
  """
  def find_peers_connected_to(peer) do
    peer = Peer.from_string(peer)

    dht_request =
      DHTRequest.new(type: DHTRequest.Type.value(:FIND_PEERS_CONNECTED_TO_PEER), peer: peer)

    Request.new(type: Request.Type.value(:DHT), dht: dht_request)
    |> Serialize.serialize()
    |> IpcClient.post_request()
  end

  @doc """
  Clients can issue a FIND_PROVIDERS request to query the DHT for peers that have a piece of content, identified by a CID.
  FIND_PROVIDERS optionally include a count, specifying a maximum number of results to return.
  """
  def find_providers(cid, count \\ 10) do
    cid = B58.encode58(cid)

    dht_request =
      DHTRequest.new(type: DHTRequest.Type.value(:FIND_PROVIDERS), cid: cid, count: count)

    Request.new(type: Request.Type.value(:DHT), dht: dht_request)
    |> Serialize.serialize()
    |> IpcClient.post_request()
  end

  @doc """
  Clients can issue a GET_CLOSEST_PEERS request to query the DHT routing table for peers that are closest to a provided key.
  """
  def get_closest_peers(key) do
    dht_request = DHTRequest.new(type: DHTRequest.Type.value(:GET_CLOSEST_PEERS), key: key)

    Request.new(type: Request.Type.value(:DHT), dht: dht_request)
    |> Serialize.serialize()
    |> IpcClient.post_request()
  end

  @doc """
  Clients can issue a GET_PUBLIC_KEY request to query the DHT routing table for a given peer's public key.
  """
  def get_public_key(peer) do
    peer = Peer.from_string(peer)
    dht_request = DHTRequest.new(type: DHTRequest.Type.value(:GET_PUBLIC_KEY), peer: peer)

    Request.new(type: Request.Type.value(:DHT), dht: dht_request)
    |> Serialize.serialize()
    |> IpcClient.post_request()
  end

  @doc """
  Clients can issue a GET_VALUE request to query the DHT for a value stored at a key in the DHT.
  """
  def get_value(key) do
    dht_request = DHTRequest.new(type: DHTRequest.Type.value(:GET_VALUE), key: key)

    Request.new(type: Request.Type.value(:DHT), dht: dht_request)
    |> Serialize.serialize()
    |> IpcClient.post_request()
  end

  @doc """
  Clients can issue a SEARCH_VALUE request to query the DHT for the best/most valid value stored at a given key.
  It will return a stream of values, terminating on the best/most valid value found. After the daemon finishes its query,
  it will update any peers in the DHT that returned stale or bad data for the given key with the better record.
  """
  def search_value(key) do
    dht_request = DHTRequest.new(type: DHTRequest.Type.value(:SEARCH_VALUE), key: key)

    Request.new(type: Request.Type.value(:DHT), dht: dht_request)
    |> Serialize.serialize()
    |> IpcClient.post_request()
  end

  @doc """
  Clients can issue a PUT_VALUE request to write a value to a key in the DHT.
  """
  def put_value(key, value) do
    dht_request = DHTRequest.new(type: DHTRequest.Type.value(:PUT_VALUE), key: key, value: value)

    Request.new(type: Request.Type.value(:DHT), dht: dht_request)
    |> Serialize.serialize()
    |> IpcClient.post_request()
  end

  @doc """
  Clients can issue a PROVIDE request to announce that they have data addressed by a given CID.
  """
  def provide(cid) do
    dht_request = DHTRequest.new(type: DHTRequest.Type.value(:PROVIDE), cid: cid)

    Request.new(type: Request.Type.value(:DHT), dht: dht_request)
    |> Serialize.serialize()
    |> IpcClient.post_request()
  end
end
