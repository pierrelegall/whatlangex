defmodule WhatlangexTest do
  use ExUnit.Case

  import Whatlangex

  @sentences %{
    eng: "Start with a simple sentence, it's good enough for now.",
    fra: "Commence avec une phrase simple, ça suffit four le moment.",
    spa: "Comience con una oración simple, es lo suficientemente bueno por ahora."
  }

  describe "#detect" do
    test "detects return a language detection" do
      for {_lang, sentence} <- @sentences do
        {:ok, %Whatlangex.Detection{} = detection} = detect(sentence)

        assert detection.lang =~ ~r/.../
        assert is_binary(detection.script)
        assert detection.confidence >= 0
        assert detection.confidence <= 1
      end
    end

    test "do not detect empty sentence" do
      assert detect("") == :none
    end
  end

  describe "#code_to_name" do
    test "returns the full name of a language" do
      assert code_to_name("fra") == {:ok, "Français"}
    end

    test "returns :none if language code is unknown" do
      assert code_to_name("abc") == :not_found
    end
  end

  describe "#code_to_eng_name" do
    test "returns the full name of a language" do
      assert code_to_eng_name("eng") == {:ok, "English"}
    end

    test "returns :none if language code is unknown" do
      assert code_to_eng_name("abc") == :not_found
    end
  end
end
