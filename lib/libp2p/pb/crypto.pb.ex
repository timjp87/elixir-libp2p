defmodule Crypto.Pb.PublicKey do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          Type: atom | integer,
          Data: binary
        }
  defstruct [:Type, :Data]

  field :Type, 1, required: true, type: Crypto.Pb.KeyType, enum: true
  field :Data, 2, required: true, type: :bytes
end

defmodule Crypto.Pb.PrivateKey do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          Type: atom | integer,
          Data: binary
        }
  defstruct [:Type, :Data]

  field :Type, 1, required: true, type: Crypto.Pb.KeyType, enum: true
  field :Data, 2, required: true, type: :bytes
end

defmodule Crypto.Pb.KeyType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2

  field :RSA, 0
  field :Ed25519, 1
  field :Secp256k1, 2
  field :ECDSA, 3
end
