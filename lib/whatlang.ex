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

  @doc """
  Get full language name (in english) from language code.

  ## Examples

      iex> Whatlang.code_to_name("eng")
      "English"

  """
  @spec code_to_name(String.t()) :: String.t()
  def code_to_name(_sentence) do
    :erlang.nif_error(:nif_not_loaded)
  end
end
