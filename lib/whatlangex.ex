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
      {:ok, %Whatlangex.Detection{lang: "eng", script: "Latin", confidence: 0.47970281937238757}}

  """
  @spec detect(String.t()) :: {:ok, Detection.t()} | :none
  def detect(sentence) do
    case nif_detect(sentence) do
      nil ->
        :none

      {lang, script, confidence} ->
        {:ok, %Detection{lang: lang, script: script, confidence: confidence}}
    end
  end

  @doc """
  Get full language name (native) from language code.

  ## Examples

      iex> code_to_name("fra")
      {:ok, "Français"}

  """
  @spec code_to_name(String.t()) :: {:ok, String.t()} | :not_found
  def code_to_name(sentence) do
    case nif_code_to_name(sentence) do
      nil -> :not_found
      lang_name -> {:ok, lang_name}
    end
  end

  @doc """
  Get full language name (in English) from language code.

  ## Examples

      iex> code_to_eng_name("fra")
      {:ok, "French"}

  """
  @spec code_to_eng_name(String.t()) :: {:ok, String.t()} | :not_found
  def code_to_eng_name(sentence) do
    case nif_code_to_eng_name(sentence) do
      nil -> :not_found
      lang_name -> {:ok, lang_name}
    end
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
