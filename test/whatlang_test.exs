defmodule WhatlangTest do
  use ExUnit.Case

  @sentences %{
    eng: "Start with a simple sentence, it's good enough for now.",
    fra: "Commence avec une phrase simple, ça suffit.",
    spa: "Comience con una oración simple, es lo suficientemente bueno por ahora."
  }

  test "detect language" do
    assert Whatlang.detect(@sentences.eng) =~ ~r/.../
    assert Whatlang.detect(@sentences.fra) =~ ~r/.../
    assert Whatlang.detect(@sentences.eng) =~ ~r/.../
  end

  test "do not detect empty sentence" do
    assert Whatlang.detect("") == "?"
  end
end
