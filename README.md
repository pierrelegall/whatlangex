# Whatlangex

[Whatlang](https://github.com/greyblake/whatlang-rs) NIF bindings for Elixir.

This package is in the early stage of development. API breaks incomin'!

## Installation

The package can be installed by adding `whatlangex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:whatlangex, "~> 0.1.0"}
  ]
end
```

## How to use

Detect a sentence language:

```elixir
iex> Whatlangex.detect("This is a cool sentence")
"eng"
```

Get full language name (in english) from language code:

```elixir
iex> Whatlangex.code_to_name("eng")
"English"
```
