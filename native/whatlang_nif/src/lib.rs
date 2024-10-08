use rustler;
use whatlang;

type NifInfo = (String, String, f64);

#[rustler::nif]
fn nif_detect(sentence: &str) -> Option<NifInfo> {
    match whatlang::detect(sentence) {
        Some(info) => Some(decode_info(info)),
        None => None,
    }
}

#[rustler::nif]
fn nif_code_to_name(code: &str) -> Option<&str> {
    match whatlang::Lang::from_code(code) {
        Some(lang) => Some(whatlang::Lang::name(lang)),
        None => None,
    }
}

#[rustler::nif]
fn nif_code_to_eng_name(code: &str) -> Option<&str> {
    match whatlang::Lang::from_code(code) {
        Some(lang) => Some(whatlang::Lang::eng_name(lang)),
        None => None,
    }
}

fn decode_info(info: whatlang::Info) -> NifInfo {
    (
        String::from(info.lang().code()),
        String::from(info.script().name()),
        info.confidence() as f64,
    )
}

rustler::init!("Elixir.Whatlangex");
