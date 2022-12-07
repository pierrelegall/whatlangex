# Whatlangex

[Whatlang](https://github.com/greyblake/whatlang-rs) NIF bindings for Elixir.

## Installation

The package can be installed by adding `whatlangex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:whatlangex, "~> 0.2.0"}
  ]
end
```

## How to use

To detect the language of a sentence:

```elixir
iex> detect("This is a nice sentence, don't you think?")
{:ok,
 %Whatlangex.Detection{
   lang: "eng",
   script: "Latin",
   confidence: 0.5628587066030453
 }}
```

To get full language name (in english) from language code:

```elixir
iex> code_to_eng_name("jap")
"English"
```

Or in the native language:

```elixir
iex> code_to_eng_name("slv")
"Slovenščina"
```
