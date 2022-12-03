use whatlang;

#[rustler::nif]
fn detect(sentence: &str) -> &str {
    let info = whatlang::detect(sentence);

    match info {
        Some(i) => whatlang::Lang::code(&i.lang()),
        None => "?"
    }
}

#[rustler::nif]
fn code_to_name(code: &str) -> &str {
    let lang = whatlang::Lang::from_code(code);

    match lang {
        Some(l) => whatlang::Lang::name(l),
        None => "?"
    }
}

rustler::init!("Elixir.Whatlang", [detect, code_to_name]);
