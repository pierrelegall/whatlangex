use rustler::NifStruct;
use whatlang;

#[derive(NifStruct)]
#[module = "Whatlangex.DetectOpts"]
struct DetectOpts {
    allowlist: Option<Vec<String>>,
    denylist: Option<Vec<String>>,
}

#[derive(NifStruct)]
#[module = "Whatlangex.Detection"]
struct Detection {
    lang: String,
    script: String,
    confidence: f64,
}

#[rustler::nif]
fn nif_detect(sentence: &str, opts: DetectOpts) -> Option<Detection> {
    build_detector(opts).detect(sentence).map(|info| Detection {
        lang: String::from(info.lang().code()),
        script: String::from(info.script().name()),
        confidence: info.confidence() as f64,
    })
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

fn build_detector(opts: DetectOpts) -> whatlang::Detector {
    match (opts.allowlist, opts.denylist) {
        // Default: no filtering
        (None, None) => whatlang::Detector::new(),
        // Apply allowlist (takes precedence)
        (Some(codes), _) => {
            let langs = codes_to_langs(&codes);
            whatlang::Detector::with_allowlist(langs)
        }
        // Apply denylist (if no allowlist)
        (None, Some(codes)) => {
            let langs = codes_to_langs(&codes);
            whatlang::Detector::with_denylist(langs)
        }
    }
}

fn codes_to_langs(codes: &[String]) -> Vec<whatlang::Lang> {
    codes
        .iter()
        .filter_map(|code| whatlang::Lang::from_code(code))
        .collect()
}

rustler::init!("Elixir.Whatlangex");
