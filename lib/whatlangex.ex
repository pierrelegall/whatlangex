defmodule Whatlangex do
  @moduledoc """
  NIF bindings for Whatlang, a natural language detection library written in Rust.
  """

  use Rustler, otp_app: :whatlangex, crate: "whatlang_nif"

  defmodule Detection do
    @moduledoc """
    Struct representing a language detection result.
    """

    @type t :: %__MODULE__{
            lang: String.t(),
            script: String.t(),
            confidence: float
          }

    defstruct [:lang, :script, :confidence]
  end

  defmodule DetectOpts do
    @moduledoc """
    Options for language detection filtering.
    """

    @type t :: %__MODULE__{
            allowlist: [String.t()] | nil,
            denylist: [String.t()] | nil
          }

    defstruct allowlist: nil, denylist: nil
  end

  @doc """
  Detect the language of the given sentence.

  ## Examples

      iex> detect("This is a cool sentence.")
      %Whatlangex.Detection{lang: "eng", script: "Latin", confidence: ...}

      iex> detect("")
      nil

  """
  @spec detect(String.t()) :: Detection.t() | nil
  def detect(sentence) do
    nif_detect(sentence, %DetectOpts{})
  end

  @doc """
  Detect the language of the given sentence with filtering options.

  ## Options

  - `:allowlist` - List of language codes to consider (e.g., `["eng", "fra", "spa"]`)
  - `:denylist` - List of language codes to exclude (e.g., `["rus", "ukr"]`)

  Note: `allowlist` and `denylist` are mutually exclusive. If both are provided, only `allowlist` will be used.

  ## Examples

      iex> detect("Ceci est une phrase.", allowlist: ["eng", "fra"])
      %Whatlangex.Detection{lang: "fra", script: "Latin", confidence: ...}

      iex> detect("Hello world", denylist: ["spa", "fra"])
      %Whatlangex.Detection{lang: "eng", script: "Latin", confidence: ...}

      iex> detect("", allowlist: ["eng"])
      nil

  """
  @spec detect(String.t(), keyword()) :: Detection.t() | nil
  def detect(sentence, opts) when is_list(opts) do
    options = %DetectOpts{
      allowlist: Keyword.get(opts, :allowlist),
      denylist: Keyword.get(opts, :denylist)
    }

    nif_detect(sentence, options)
  end

  @doc """
  Get the full language native name from language code.

  ## Examples

      iex> code_to_name("fra")
      "Français"

      iex> code_to_name("abc")
      nil

  """
  @spec code_to_name(String.t()) :: String.t() | nil
  def code_to_name(code) do
    nif_code_to_name(code)
  end

  @doc """
  Get the full language English name from language code.

  ## Examples

      iex> code_to_eng_name("fra")
      "French"

      iex> code_to_eng_name("abc")
      nil

  """
  @spec code_to_eng_name(String.t()) :: String.t() | nil
  def code_to_eng_name(code) do
    nif_code_to_eng_name(code)
  end

  defp nif_detect(_sentence, _options) do
    error_if_not_nif_loaded()
  end

  defp nif_code_to_name(_code) do
    error_if_not_nif_loaded()
  end

  defp nif_code_to_eng_name(_code) do
    error_if_not_nif_loaded()
  end

  defp error_if_not_nif_loaded do
    :erlang.nif_error(:nif_not_loaded)
  end
end
