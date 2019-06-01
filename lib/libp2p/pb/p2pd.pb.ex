defmodule P2pd.Pb.Request do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          type: atom | integer,
          connect: P2pd.Pb.ConnectRequest.t() | nil,
          streamOpen: P2pd.Pb.StreamOpenRequest.t() | nil,
          streamHandler: P2pd.Pb.StreamHandlerRequest.t() | nil,
          dht: P2pd.Pb.DHTRequest.t() | nil,
          connManager: P2pd.Pb.ConnManagerRequest.t() | nil,
          disconnect: P2pd.Pb.DisconnectRequest.t() | nil,
          pubsub: P2pd.Pb.PSRequest.t() | nil
        }
  defstruct [
    :type,
    :connect,
    :streamOpen,
    :streamHandler,
    :dht,
    :connManager,
    :disconnect,
    :pubsub
  ]

  field :type, 1, required: true, type: P2pd.Pb.Request.Type, enum: true
  field :connect, 2, optional: true, type: P2pd.Pb.ConnectRequest
  field :streamOpen, 3, optional: true, type: P2pd.Pb.StreamOpenRequest
  field :streamHandler, 4, optional: true, type: P2pd.Pb.StreamHandlerRequest
  field :dht, 5, optional: true, type: P2pd.Pb.DHTRequest
  field :connManager, 6, optional: true, type: P2pd.Pb.ConnManagerRequest
  field :disconnect, 7, optional: true, type: P2pd.Pb.DisconnectRequest
  field :pubsub, 8, optional: true, type: P2pd.Pb.PSRequest
end

defmodule P2pd.Pb.Request.Type do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2

  field :IDENTIFY, 0
  field :CONNECT, 1
  field :STREAM_OPEN, 2
  field :STREAM_HANDLER, 3
  field :DHT, 4
  field :LIST_PEERS, 5
  field :CONNMANAGER, 6
  field :DISCONNECT, 7
  field :PUBSUB, 8
end

defmodule P2pd.Pb.Response do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          type: atom | integer,
          error: P2pd.Pb.ErrorResponse.t() | nil,
          streamInfo: P2pd.Pb.StreamInfo.t() | nil,
          identify: P2pd.Pb.IdentifyResponse.t() | nil,
          dht: P2pd.Pb.DHTResponse.t() | nil,
          peers: [P2pd.Pb.PeerInfo.t()],
          pubsub: P2pd.Pb.PSResponse.t() | nil
        }
  defstruct [:type, :error, :streamInfo, :identify, :dht, :peers, :pubsub]

  field :type, 1, required: true, type: P2pd.Pb.Response.Type, enum: true
  field :error, 2, optional: true, type: P2pd.Pb.ErrorResponse
  field :streamInfo, 3, optional: true, type: P2pd.Pb.StreamInfo
  field :identify, 4, optional: true, type: P2pd.Pb.IdentifyResponse
  field :dht, 5, optional: true, type: P2pd.Pb.DHTResponse
  field :peers, 6, repeated: true, type: P2pd.Pb.PeerInfo
  field :pubsub, 7, optional: true, type: P2pd.Pb.PSResponse
end

defmodule P2pd.Pb.Response.Type do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2

  field :OK, 0
  field :ERROR, 1
end

defmodule P2pd.Pb.IdentifyResponse do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          id: binary,
          addrs: [binary]
        }
  defstruct [:id, :addrs]

  field :id, 1, required: true, type: :bytes
  field :addrs, 2, repeated: true, type: :bytes
end

defmodule P2pd.Pb.ConnectRequest do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          peer: binary,
          addrs: [binary],
          timeout: integer
        }
  defstruct [:peer, :addrs, :timeout]

  field :peer, 1, required: true, type: :bytes
  field :addrs, 2, repeated: true, type: :bytes
  field :timeout, 3, optional: true, type: :int64
end

defmodule P2pd.Pb.StreamOpenRequest do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          peer: binary,
          proto: [String.t()],
          timeout: integer
        }
  defstruct [:peer, :proto, :timeout]

  field :peer, 1, required: true, type: :bytes
  field :proto, 2, repeated: true, type: :string
  field :timeout, 3, optional: true, type: :int64
end

defmodule P2pd.Pb.StreamHandlerRequest do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          addr: binary,
          proto: [String.t()]
        }
  defstruct [:addr, :proto]

  field :addr, 1, required: true, type: :bytes
  field :proto, 2, repeated: true, type: :string
end

defmodule P2pd.Pb.ErrorResponse do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          msg: String.t()
        }
  defstruct [:msg]

  field :msg, 1, required: true, type: :string
end

defmodule P2pd.Pb.StreamInfo do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          peer: binary,
          addr: binary,
          proto: String.t()
        }
  defstruct [:peer, :addr, :proto]

  field :peer, 1, required: true, type: :bytes
  field :addr, 2, required: true, type: :bytes
  field :proto, 3, required: true, type: :string
end

defmodule P2pd.Pb.DHTRequest do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          type: atom | integer,
          peer: binary,
          cid: binary,
          key: binary,
          value: binary,
          count: integer,
          timeout: integer
        }
  defstruct [:type, :peer, :cid, :key, :value, :count, :timeout]

  field :type, 1, required: true, type: P2pd.Pb.DHTRequest.Type, enum: true
  field :peer, 2, optional: true, type: :bytes
  field :cid, 3, optional: true, type: :bytes
  field :key, 4, optional: true, type: :bytes
  field :value, 5, optional: true, type: :bytes
  field :count, 6, optional: true, type: :int32
  field :timeout, 7, optional: true, type: :int64
end

defmodule P2pd.Pb.DHTRequest.Type do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2

  field :FIND_PEER, 0
  field :FIND_PEERS_CONNECTED_TO_PEER, 1
  field :FIND_PROVIDERS, 2
  field :GET_CLOSEST_PEERS, 3
  field :GET_PUBLIC_KEY, 4
  field :GET_VALUE, 5
  field :SEARCH_VALUE, 6
  field :PUT_VALUE, 7
  field :PROVIDE, 8
end

defmodule P2pd.Pb.DHTResponse do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          type: atom | integer,
          peer: P2pd.Pb.PeerInfo.t() | nil,
          value: binary
        }
  defstruct [:type, :peer, :value]

  field :type, 1, required: true, type: P2pd.Pb.DHTResponse.Type, enum: true
  field :peer, 2, optional: true, type: P2pd.Pb.PeerInfo
  field :value, 3, optional: true, type: :bytes
end

defmodule P2pd.Pb.DHTResponse.Type do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2

  field :BEGIN, 0
  field :VALUE, 1
  field :END, 2
end

defmodule P2pd.Pb.PeerInfo do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          id: binary,
          addrs: [binary]
        }
  defstruct [:id, :addrs]

  field :id, 1, required: true, type: :bytes
  field :addrs, 2, repeated: true, type: :bytes
end

defmodule P2pd.Pb.ConnManagerRequest do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          type: atom | integer,
          peer: binary,
          tag: String.t(),
          weight: integer
        }
  defstruct [:type, :peer, :tag, :weight]

  field :type, 1, required: true, type: P2pd.Pb.ConnManagerRequest.Type, enum: true
  field :peer, 2, optional: true, type: :bytes
  field :tag, 3, optional: true, type: :string
  field :weight, 4, optional: true, type: :int64
end

defmodule P2pd.Pb.ConnManagerRequest.Type do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2

  field :TAG_PEER, 0
  field :UNTAG_PEER, 1
  field :TRIM, 2
end

defmodule P2pd.Pb.DisconnectRequest do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          peer: binary
        }
  defstruct [:peer]

  field :peer, 1, required: true, type: :bytes
end

defmodule P2pd.Pb.PSRequest do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          type: atom | integer,
          topic: String.t(),
          data: binary
        }
  defstruct [:type, :topic, :data]

  field :type, 1, required: true, type: P2pd.Pb.PSRequest.Type, enum: true
  field :topic, 2, optional: true, type: :string
  field :data, 3, optional: true, type: :bytes
end

defmodule P2pd.Pb.PSRequest.Type do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2

  field :GET_TOPICS, 0
  field :LIST_PEERS, 1
  field :PUBLISH, 2
  field :SUBSCRIBE, 3
end

defmodule P2pd.Pb.PSMessage do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          from: binary,
          data: binary,
          seqno: binary,
          topicIDs: [String.t()],
          signature: binary,
          key: binary
        }
  defstruct [:from, :data, :seqno, :topicIDs, :signature, :key]

  field :from, 1, optional: true, type: :bytes
  field :data, 2, optional: true, type: :bytes
  field :seqno, 3, optional: true, type: :bytes
  field :topicIDs, 4, repeated: true, type: :string
  field :signature, 5, optional: true, type: :bytes
  field :key, 6, optional: true, type: :bytes
end

defmodule P2pd.Pb.PSResponse do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          topics: [String.t()],
          peerIDs: [binary]
        }
  defstruct [:topics, :peerIDs]

  field :topics, 1, repeated: true, type: :string
  field :peerIDs, 2, repeated: true, type: :bytes
end
