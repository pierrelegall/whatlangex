use rustler;
use whatlang;

type NifOptsInput = (Option<Vec<String>>, Option<Vec<String>>);
type NifInfoOutput = (String, String, f64);

#[rustler::nif]
fn nif_detect(sentence: &str, opts: NifOptsInput) -> Option<NifInfoOutput> {
    build_detector(opts).detect(sentence).map(decode_info)
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

fn build_detector(opts: NifOptsInput) -> whatlang::Detector {
    match opts {
        // Allowlist takes precedence
        (Some(codes), _) => {
            let langs = codes_to_langs(&codes);
            if !langs.is_empty() {
                whatlang::Detector::with_allowlist(langs)
            } else {
                whatlang::Detector::new()
            }
        }
        // Denylist if no allowlist
        (None, Some(codes)) => {
            let langs = codes_to_langs(&codes);
            if !langs.is_empty() {
                whatlang::Detector::with_denylist(langs)
            } else {
                whatlang::Detector::new()
            }
        }
        // Default: no filtering
        _ => whatlang::Detector::new(),
    }
}

fn codes_to_langs(codes: &[String]) -> Vec<whatlang::Lang> {
    codes
        .iter()
        .filter_map(|code| whatlang::Lang::from_code(code))
        .collect()
}

fn decode_info(info: whatlang::Info) -> NifInfoOutput {
    (
        String::from(info.lang().code()),
        String::from(info.script().name()),
        info.confidence() as f64,
    )
}

rustler::init!("Elixir.Whatlangex");
