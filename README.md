# Whatlangex

[Whatlang](https://github.com/greyblake/whatlang-rs) NIF bindings for Elixir.

## Requirements

- Elixir `1.15` or more
- Erlang OTP `24` or more

> **Note:** This project is developed and tested with Elixir `1.18.4` and Erlang OTP `28`. Please open an issue if backward compatibilities with the minimum versions listed above are not respected.

## Installation

The package can be installed by adding `whatlangex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:whatlangex, "~> 0.3.0"}
  ]
end
```

## How to use

To detect the language of a sentence:

```elixir
iex> Whatlangex.detect("¿Cómo te llamas?")
%Whatlangex.Detection{
  lang: "spa",
  script: "Latin",
  confidence: 0.6848222396112233
}
```

To get the full language name from language code:

```elixir
iex> Whatlangex.code_to_eng_name("spa")
"Spanish"

iex> Whatlangex.code_to_name("spa")
"Español"
```
