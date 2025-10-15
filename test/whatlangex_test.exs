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

  describe "&detect/2 with allowlist" do
    test "detects language from allowlist" do
      detection = detect(@sentences.fra, allowlist: ["eng", "fra", "spa"])

      assert %Whatlangex.Detection{} = detection
      assert detection.lang == "fra"
    end

    test "detects English when limited to English and Spanish" do
      detection = detect(@sentences.eng, allowlist: ["eng", "spa"])

      assert %Whatlangex.Detection{} = detection
      assert detection.lang == "eng"
    end

    test "returns another lang when allowlist doesn't match" do
      detection = detect("Guten Tag, wie geht es Ihnen?", allowlist: ["fra", "spa"])

      assert detection.lang in ["fra", "spa"]
    end

    test "empty allowlist returns nil" do
      detection = detect(@sentences.eng, allowlist: [])

      assert detection == nil
    end
  end

  describe "&detect/2 with denylist" do
    test "detects language excluding denied languages" do
      detection = detect(@sentences.eng, denylist: ["fra", "spa", "deu"])

      assert %Whatlangex.Detection{} = detection
      assert detection.lang == "eng"
    end

    test "excludes specific language from detection" do
      detection = detect(@sentences.spa, denylist: ["eng", "fra"])

      assert %Whatlangex.Detection{} = detection
      assert detection.lang == "spa"
    end

    test "handles empty denylist gracefully" do
      detection = detect(@sentences.fra, denylist: [])

      assert %Whatlangex.Detection{} = detection
      assert detection.lang == "fra"
    end
  end

  describe "&detect/2 with invalid language codes" do
    test "ignores invalid codes in allowlist" do
      detection = detect(@sentences.eng, allowlist: ["eng", "invalid", "xyz"])

      assert %Whatlangex.Detection{} = detection
      assert detection.lang == "eng"
    end

    test "ignores invalid codes in denylist" do
      detection = detect(@sentences.fra, denylist: ["invalid", "xyz"])

      assert %Whatlangex.Detection{} = detection
      assert detection.lang == "fra"
    end
  end

  describe "&detect/2 with both allowlist and denylist" do
    test "allowlist takes precedence when both are provided" do
      detection = detect(@sentences.eng, allowlist: ["eng", "fra"], denylist: ["eng", "spa"])

      assert %Whatlangex.Detection{} = detection
      assert detection.lang == "eng"
    end

    test "denylist is ignored when allowlist is present" do
      detection = detect(@sentences.fra, allowlist: ["spa", "deu"], denylist: ["fra"])

      assert detection.lang in ["spa", "deu"]
    end

    test "allowlist with value takes precedence over empty denylist" do
      detection = detect(@sentences.eng, allowlist: ["eng", "fra"], denylist: [])

      assert %Whatlangex.Detection{} = detection
      assert detection.lang == "eng"
    end

    test "empty allowlist with denylist behave as allowlist filtering" do
      detection = detect(@sentences.fra, allowlist: [], denylist: ["eng", "spa"])

      assert detection == nil
    end

    test "both empty lists behave as allowlist filtering" do
      detection = detect(@sentences.spa, allowlist: [], denylist: [])

      assert detection == nil
    end

    test "conflicting options with overlapping languages" do
      detection =
        detect(@sentences.fra, allowlist: ["eng", "fra", "spa"], denylist: ["fra", "deu"])

      assert %Whatlangex.Detection{} = detection
      assert detection.lang == "fra"
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
