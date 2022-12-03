use whatlang;

#[rustler::nif]
fn detect(sentence: &str) -> &str {
    let info = whatlang::detect(sentence);

    match info {
        Some(i) => whatlang::Lang::code(&i.lang()),
        None => "?"
    }
    }
}

rustler::init!("Elixir.Whatlang", [detect]);
