defmodule Whatlang do
  @moduledoc """
  Documentation for `Whatlang`.
  """

  use Rustler, otp_app: :whatlang, crate: "whatlang_elixir"

  @doc """
  Detect the language of the given sentence.

  ## Examples

      iex> Whatlang.detect("This is a cool sentence.")
      "eng"

  """
  @spec detect(String.t()) :: String.t()
  def detect(_sentence) do
    :erlang.nif_error(:nif_not_loaded)
  end
end
