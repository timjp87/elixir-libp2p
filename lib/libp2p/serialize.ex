defmodule Libp2p.Serialize do
  def serialize(msg) do
    msg
    |> P2pd.Pb.Request.encode()
    |> length_prefix
  end

  defp length_prefix(msg) do
    <<Kernel.byte_size(msg)>> <> msg
  end
end
