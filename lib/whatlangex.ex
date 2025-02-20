defmodule Whatlangex do
  @moduledoc """
  Documentation for `Whatlang`.
  """

  use Rustler, otp_app: :whatlangex, crate: "whatlang_nif"

  defmodule Detection do
    @moduledoc """
    Module of the Detection type.
    """

    @type t :: %__MODULE__{
            lang: String.t(),
            script: String.t(),
            confidence: float
          }

    defstruct [:lang, :script, :confidence]
  end

  @doc """
  Detect the language of the given sentence.

  ## Examples

      iex> detect("This is a cool sentence.")
      %Whatlangex.Detection{lang: "eng", script: "Latin", confidence: 0.47970281937238757}

      iex> detect("")
      nil

  """
  @spec detect(String.t()) :: Detection.t() | nil
  def detect(sentence) do
    case nif_detect(sentence) do
      nil ->
        nil

      {lang, script, confidence} ->
        %Detection{lang: lang, script: script, confidence: confidence}
    end
  end

  @doc """
  Get full language name (native) from language code.

  ## Examples

      iex> code_to_name("fra")
      "Français"

      iex> code_to_name("abc")
      nil

  """
  @spec code_to_name(String.t()) :: String.t() | nil
  def code_to_name(sentence) do
    nif_code_to_name(sentence)
  end

  @doc """
  Get full language name (in English) from language code.

  ## Examples

      iex> code_to_eng_name("fra")
      "French"

      iex> code_to_eng_name("abc")
      nil

  """
  @spec code_to_eng_name(String.t()) :: String.t() | nil
  def code_to_eng_name(sentence) do
    nif_code_to_eng_name(sentence)
  end

  defp nif_detect(_sentence) do
    error_if_not_nif_loaded()
  end

  defp nif_code_to_name(_sentence) do
    error_if_not_nif_loaded()
  end

  defp nif_code_to_eng_name(_sentence) do
    error_if_not_nif_loaded()
  end

  defp error_if_not_nif_loaded do
    :erlang.nif_error(:nif_not_loaded)
  end
end
