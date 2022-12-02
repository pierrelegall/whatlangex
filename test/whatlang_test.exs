defmodule WhatlangTest do
  use ExUnit.Case
  doctest Whatlang

  test "greets the world" do
    assert Whatlang.hello() == :world
  end
end
