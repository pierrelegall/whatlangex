defmodule Whatlangex do
  @moduledoc """
  Documentation for `Whatlang`.
  """

  use Rustler, otp_app: :whatlangex, crate: "whatlang_elixir"

  defmodule Detection do
    @moduledoc """
    Module of the Detection type.
    """

    @type t :: %__MODULE__{
            lang: String.t(),
            script: String.t(),
            confidence: Float.t()
          }

    defstruct [:lang, :script, :confidence]
  end

  @doc """
  Detect the language of the given sentence.

  ## Examples

      iex> detect("This is a cool sentence.")
      "eng"

  """
  @spec detect(String.t()) :: {:ok, Detection.t()} | :none
  def detect(sentence) do
    case nif_detect(sentence) do
      {lang, script, confidence} ->
        {:ok, %Detection{lang: lang, script: script, confidence: confidence}}

      nil ->
        :none
    end
  end

  @doc """
  Get full language name (in english) from language code.

  ## Examples

      iex> code_to_name("eng")
      "English"

  """
  @spec code_to_name(String.t()) :: String.t()
  def code_to_name(sentence) do
    nif_code_to_name(sentence)
  end

  defp nif_detect(_sentence) do
    error_if_not_nif_loaded()
  end

  def nif_code_to_name(_sentence) do
    error_if_not_nif_loaded()
  end

  defp error_if_not_nif_loaded do
    :erlang.nif_error(:nif_not_loaded)
  end
end
