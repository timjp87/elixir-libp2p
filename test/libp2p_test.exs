defmodule Libp2pTest do
  use ExUnit.Case
  doctest Libp2p

  test "greets the world" do
    assert Libp2p.hello() == :world
  end
end
