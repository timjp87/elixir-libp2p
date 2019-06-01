defmodule Libp2p.PubSub do
  @moduledoc """
  The libp2p daemon PubSub protocol allows clients to subscribe and publish to topics using libp2p PubSub.
  """
  alias Libp2p.{IpcClient, Serialize}
  alias P2pd.Pb.{Request, PSRequest}

  @doc """
  Clients can issue a GET_TOPICS request to get a list of topics the node is subscribed to.
  """
  def get_topics do
    ps_request = PSRequest.new(type: PSRequest.Type.value(:GET_TOPICS))

    Request.new(type: Request.Type.value(:PUBSUB), pubsub: ps_request)
    |> Serialize.serialize()
    |> IpcClient.post_request()
  end

  @doc """
  Clients can issue a LIST_PEERS request to get a list of IDs of peers the node is connected to.
  """
  def list_peers do
    ps_request = PSRequest.new(type: PSRequest.Type.value(:LIST_PEERS))

    Request.new(type: Request.Type.value(:PUBSUB), pubsub: ps_request)
    |> Serialize.serialize()
    |> IpcClient.post_request()
  end

  @doc """
  Clients can issue a PUBLISH request to publish data under a topic.
  """
  def publish(topic, data) do
    ps_request = PSRequest.new(type: PSRequest.Type.value(:PUBLISH), topic: topic, data: data)

    Request.new(type: Request.Type.value(:PUBSUB), pubsub: ps_request)
    |> Serialize.serialize()
    |> IpcClient.post_request()
  end

  @doc """
  Clients can issue a SUBSCRIBE request to subscribe to a certain topic.
  """
  def subscribe(topic) do
    ps_request = PSRequest.new(type: PSRequest.Type.value(:SUBSCRIBE), topic: topic)

    Request.new(type: Request.Type.value(:PUBSUB), pubsub: ps_request)
    |> Serialize.serialize()
    |> IpcClient.post_request()
  end
end
