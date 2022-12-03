# Elixir.Whatlang

[Whatlang](https://github.com/greyblake/whatlang-rs) NIF bindings for Elixir.

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
