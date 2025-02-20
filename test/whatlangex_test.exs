defmodule WhatlangexTest do
  use ExUnit.Case, async: true

  import Whatlangex

  @sentences %{
    eng: "Start with a simple sentence, it's good enough for now.",
    fra: "Commence avec une phrase simple, ça suffit pour le moment.",
    spa: "Comience con una oración simple, es lo suficientemente bueno por ahora."
  }

  describe "&detect/1" do
    test "returns a language detection" do
      for {_lang, sentence} <- @sentences do
        detection = detect(sentence)

        assert %Whatlangex.Detection{} = detection
        assert detection.lang =~ ~r/^...$/
        assert is_binary(detection.script)
        assert detection.confidence >= 0
        assert detection.confidence <= 1
      end
    end

    test "returns `nil` with an empty sentence" do
      assert detect("") == nil
    end
  end

  describe "&code_to_name/1" do
    test "returns the full name of a language" do
      assert code_to_name("eng") == "English"
      assert code_to_name("fra") == "Français"
      assert code_to_name("spa") == "Español"
    end

    test "returns :none if language code is unknown" do
      assert code_to_name("abc") == nil
    end
  end

  describe "&code_to_eng_name/1" do
    test "returns the full name of a language" do
      assert code_to_eng_name("eng") == "English"
      assert code_to_eng_name("fra") == "French"
      assert code_to_eng_name("spa") == "Spanish"
    end

    test "returns :none if language code is unknown" do
      assert code_to_eng_name("abc") == nil
    end
  end
end
