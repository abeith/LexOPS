corpus_recode_apa <- function(inputopts) {
  if (!is.null(inputopts)) {
    recode(inputopts,
           "bnc_w" = "the British National Corpus (written)",
           "bnc.wbg" = "the British National Corpus (written)",
           "bnc_s" = "the British National Corpus (spoken)",
           "bnc.sbg" = "the British National Corpus (spoken)",
           "suk" = "SUBTLEX-UK",
           "subtlex_uk.bg" = "SUBTLEX-UK",
           "sus" = "SUBTLEX-US",
           "subtlex_us.bg" = "SUBTLEX-US",
           "elp" = "the English Lexicon Project",
           "blp" = "the British Lexicon Project",
           "mp" = "the Moby Project",
           "cmu" = "the CMU Pronouncing Dictionary",
           "gn" = "the Glasgow Norms",
           "cp" = "Clark and Paivio (2004)",
           "kuperman" = "Kuperman et al. (2012)",
           "bb" = "Brysbaert & Biemiller (2017)",
           "brysbaert" = "Brysbaert et al. (2014)",
           "warriner" = "Warriner et al. (2013)",
           "eh" = "Engelthaler & Hills (2018)"
    )
  } else {
    NA
  }
}

corpus_recode <- function(inputopts = c("bnc_w", "bnc_s"), prefix=NA, logprefix=F) {
  if (!is.null(inputopts)) {
    prefix_dot <- if(is.na(prefix)) {""} else {sprintf("%s.", prefix)}
    log_prefix_str <- if(logprefix) {"Log_"} else {""}
    recoded <- recode(inputopts,
                      "bnc_w" = "BNC.Written",
                      "bnc.wbg" = "BNC.Written",
                      "bnc_s" = "BNC.Spoken",
                      "bnc.sbg" = "BNC.Spoken",
                      "suk" = "SUBTLEX_UK",
                      "subtlex_uk.bg" = "SUBTLEX_UK",
                      "sus" = "SUBTLEX_US",
                      "subtlex_us.bg" = "SUBTLEX_US",
                      "elp" = "ELP",
                      "blp" = "BLP",
                      "mp" = "Moby",
                      "cmu" = "CMU",
                      "espeak" = "eSpeak",
                      "gn" = "Glasgow_Norms",
                      "cp" = "Clark_and_Paivio",
                      "kuperman" = "Kuperman",
                      "bb" = "BrysbaertBiemiller",
                      "brysbaert" = "Brysbaert",
                      "warriner" = "Warriner",
                      "eh" = "EngelthalerHills",
                      "cn" = "Colthearts_N",
                      "old20" = "OLD20",
                      "pld20" = "PLD20",
                      "ld" = "LD",
                      "ldd" = "DLD"
    )
    sprintf("%s%s%s", prefix_dot, log_prefix_str, recoded)
  } else {
    NA
  }
}

viscat2prefix <- function(viscat, log=F) {
  recode(viscat,
         "Bigram Probability" = "BG",
         "Orthographic Similarity" = "OS",
         "Orthographic Neighbourhood" = "ON",
         "Syllables" = "Syllables",
         "Phonemes" = "Phonemes",
         "Number of Pronunciations" = "PrN",
         "Phonological Similarity" = "PS",
         "Phonological Neighbourhood" = "PN",
         "Familiarity" = "FAM",
         "Age of Acquisition" = "AoA",
         "Concreteness" = "CNC",
         "Arousal" = "AROU",
         "Valence" = "VAL",
         "Dominance" = "DOM",
         "Imageability" = "IMAG",
         "Semantic Size" = "SIZE",
         "Semantic Gender" = "GEND",
         "Humour" = "HUM",
         "Word Prevalence" = "PREV",
         "Proportion Known" = "PK",
         "Lexical Decision Response Time" = "RT",
         "Lexical Decision Accuracy" = "Accuracy",
         "Part of Speech" = "PoS",
         "Word Frequency" = if (log) {"Zipf"} else {"fpmw"},
         "Custom Variable" = "custom"
  )
}

corpus_recode_columns <- function(inputopts = c("bnc_w", "bnc_s"), v="Word Frequency", log=F, phonological_source="cmu") {
  # ensure phonological source is correct
  phonological_source <- recode(
    phonological_source,
    "cmu" = "CMU",
    "espeak" = "eSpeak.br"
  )
  case_when(
    v == "Word Frequency" ~ corpus_recode(inputopts, viscat2prefix(v, log)),
    v == "Part of Speech" ~ corpus_recode(inputopts, viscat2prefix(v)),
    v == "Length" ~ "Length",
    v == "Bigram Probability" ~ corpus_recode(inputopts, viscat2prefix(v)),
    v == "Orthographic Neighbourhood" ~ corpus_recode(inputopts, viscat2prefix(v), log),
    v == "Orthographic Similarity" ~ corpus_recode(inputopts, viscat2prefix(v)),
    v == "Syllables" ~sprintf("%s.%s", viscat2prefix(v), phonological_source),
    v == "Phonemes" ~ sprintf("%s.%s", viscat2prefix(v), phonological_source),
    v == "Rhyme" ~ sprintf("%s.%s", viscat2prefix(v), phonological_source),
    v == "Phonological Neighbourhood" ~ sprintf("%s.%s", corpus_recode(inputopts, viscat2prefix(v), log), phonological_source),
    v == "Phonological Similarity" ~ sprintf("%s.%s", corpus_recode(inputopts, viscat2prefix(v)), phonological_source),
    v == "Number of Pronunciations" ~ sprintf("%s.PrN", toupper(phonological_source)),
    v == "Word Prevalence" ~ corpus_recode(inputopts, viscat2prefix(v)),
    v == "Proportion Known" ~ corpus_recode(inputopts, viscat2prefix(v)),
    v %in% c("Familiarity", "Age of Acquisition", "Concreteness", "Arousal", "Valence", "Dominance", "Imageability", "Semantic Size", "Semantic Gender", "Humour") ~ corpus_recode(inputopts, viscat2prefix(v)),
    v %in% c("Lexical Decision Response Time", "Lexical Decision Accuracy") ~ corpus_recode(inputopts, viscat2prefix(v)),
    v == "Custom Variable" ~ corpus_recode(inputopts, viscat2prefix(v))
  )
}

viscat2scaletext <- function(v) {
  case_when(
    v == "Bigram Probability" ~ c("Less Likely", "More Likely"),
    v == "Orthographic Similarity" ~ c("More Similar", "Less Similar"),
    v == "Syllables" ~ c("Fewer", "More"),
    v == "Phonemes" ~ c("Fewer", "More"),
    v == "Number of Pronunciations" ~ c("Fewer", "More"),
    v == "Phonological Similarity" ~ c("More Similar", "Less Similar"),
    v == "Familiarity" ~ c("Less Familiar", "More Familiar"),
    v == "Age of Acquisition" ~ c("Earlier", "Later"),
    v == "Concreteness" ~ c("Less Concrete", "More Concrete"),
    v == "Arousal" ~ c("Less Arousing", "More Arousing"),
    v == "Valence" ~ c("More Negative", "More Positive"),
    v == "Dominance" ~ c("Less Dominant", "More Dominant"),
    v == "Imageability" ~ c("Less Imageable", "More Imageable"),
    v == "Semantic Size" ~ c("Smaller", "Larger"),
    v == "Semantic Gender" ~ c("More Feminine", "More Masculine"),
    v == "Humour" ~ c("Less Funny", "More Funny"),
    v == "Word Prevalence" ~ c("Less Prevalent", "More Prevalent"),
    v == "Proportion Known" ~ c("Smaller", "Larger"),
    v == "Lexical Decision Response Time" ~ c("Faster", "Slower"),
    v == "Lexical Decision Accuracy" ~ c("Less Accurate", "More Accurate"),
    v == "Custom Variable" ~ c("Lower", "Higher")
  )
}
