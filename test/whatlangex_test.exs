defmodule WhatlangexTest do
  use ExUnit.Case, async: true

  import Whatlangex

  @sentences %{
    eng: "Start with a simple sentence, it's good enough for now.",
    fra: "Commence avec une phrase simple, ça suffit four le moment.",
    spa: "Comience con una oración simple, es lo suficientemente bueno por ahora."
  }

  describe "&detect/1" do
    test "returns a language detection" do
      for {_lang, sentence} <- @sentences do
        {:ok, %Whatlangex.Detection{} = detection} = detect(sentence)

        assert detection.lang =~ ~r/^...$/
        assert is_binary(detection.script)
        assert detection.confidence >= 0
        assert detection.confidence <= 1
      end
    end

    test "returns :none with an empty sentence" do
      assert detect("") == :none
    end
  end

  describe "&code_to_name/1" do
    test "returns the full name of a language" do
      assert code_to_name("eng") == {:ok, "English"}
      assert code_to_name("fra") == {:ok, "Français"}
      assert code_to_name("spa") == {:ok, "Español"}
    end

    test "returns :none if language code is unknown" do
      assert code_to_name("abc") == :not_found
    end
  end

  describe "&code_to_eng_name/1" do
    test "returns the full name of a language" do
      assert code_to_eng_name("eng") == {:ok, "English"}
      assert code_to_eng_name("fra") == {:ok, "French"}
      assert code_to_eng_name("spa") == {:ok, "Spanish"}
    end

    test "returns :none if language code is unknown" do
      assert code_to_eng_name("abc") == :not_found
    end
  end
end
