defmodule WhatlangexTest do
  use ExUnit.Case

  import Whatlangex

  @sentences %{
    eng: "Start with a simple sentence, it's good enough for now.",
    fra: "Commence avec une phrase simple, ça suffit.",
    spa: "Comience con una oración simple, es lo suficientemente bueno por ahora."
  }

  test "detect language" do
    for {_lang, sentence} <- @sentences do
      {:ok, %Whatlangex.Detection{} = detection} = detect(sentence)

      assert detection.lang =~ ~r/.../
    end
  end

  test "do not detect empty sentence" do
    assert detect("") == :none
  end

  test "code to name" do
    assert code_to_name("eng") == "English"
  end

  test "code to name not found" do
    assert code_to_name("abc") == "?"
  end
end
