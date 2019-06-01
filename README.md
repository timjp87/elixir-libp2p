# Libp2p

[![CircleCI](https://circleci.com/gh/timjp87/elixir-libp2p.svg?style=svg)](https://circleci.com/gh/timjp87/elixir-libp2p)

OTP Application that communicates with the libp2p daemon over UNIX domain socket using Protobuf. Socket path is configured in config.exs. Libp2p API is exposed in the DHT, PubSub, ConnManager and Peer modules.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `libp2p` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:libp2p, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/libp2p](https://hexdocs.pm/libp2p).
