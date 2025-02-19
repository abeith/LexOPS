# Visualilsation vector categories
vis.cats <- c('Word Frequency', 'Part of Speech', 'Length', 'Bigram Probability', 'Orthographic Neighbourhood', 'Syllables', 'Phonemes', 'Rhyme', 'Phonological Neighbourhood', 'Number of Pronunciations', 'Familiarity', 'Age of Acquisition', 'Concreteness', 'Arousal', 'Valence', 'Dominance', 'Imageability', 'Semantic Size', 'Semantic Gender', 'Humour', 'Word Prevalence', 'Proportion Known', 'Lexical Decision Response Time', 'Lexical Decision Accuracy', 'Custom Variable')

vis.cats.match <- vis.cats %>%
  append("Phonological Similarity", after=match("Phonological Neighbourhood", vis.cats)) %>%
  append("Orthographic Similarity", after=match("Orthographic Neighbourhood", vis.cats))

vis.opt.2.source <- function(x, opts){switch(x,
                                       '(None)' = '',
                                       'Target Match Word' = '',
                                       'Suggested Matches' = '',
                                       'Words Uploaded to Fetch Tab' = '',
                                       'Part of Speech' = opts[grepl("PoS",opts)],
                                       'Length' = 'Length',
                                       'Syllables' = opts[grepl("Syllables",opts)],
                                       'Word Frequency' = opts[grepl("Zipf",opts) | grepl("fpmw",opts)],
                                       'Bigram Probability' = opts[grepl("BG",opts)],
                                       'Orthographic Neighbourhood' = opts[grepl("ON",opts)],
                                       'Phonemes' = opts[grepl("Phonemes",opts)],
                                       'Rhyme' = opts[grepl("Rhyme",opts)],
                                       'Phonological Neighbourhood' = opts[grepl("PN",opts)],
                                       'Number of Pronunciations' = opts[grepl("PrN",opts)],
                                       'Familiarity' = opts[grepl("FAM",opts)],
                                       'Age of Acquisition' = opts[grepl("AoA",opts)],
                                       'Concreteness' = opts[grepl("CNC",opts)],
                                       'Arousal' = opts[grepl("AROU",opts)],
                                       'Valence' = opts[grepl("VAL",opts)],
                                       'Dominance' = opts[grepl("DOM",opts)],
                                       'Imageability' = opts[grepl("IMAG",opts)],
                                       'Semantic Size' = opts[grepl("SIZE",opts)],
                                       'Semantic Gender' = opts[grepl("GEND",opts)],
                                       'Humour' = opts[grepl("HUM",opts)],
                                       'Word Prevalence' = opts[grepl("PREV", opts)],
                                       'Proportion Known' = opts[grepl("PK", opts)],
                                       'Lexical Decision Response Time' = opts[grepl("RT",opts)],
                                       'Lexical Decision Accuracy' = opts[grepl("Accuracy",opts)],
                                       'Custom Variable' = opts[grepl("custom.",opts)]
)}

vis.cats.non_Zscore <- c("Word Frequency", "Bigram Probability", "Lexical Decision Accuracy")

phonological.vis.cats <- c("Syllables", "Phonemes", "Rhyme", "Phonological Neighbourhood", "Number of Pronunciations", "Phonological Similarity")
