controlfor_UI <- function(vtype = "Word Frequency", boxid) {
  
  if (!is.null(vtype)) {
    
    ui <- list()
    
    if (vtype == "Word Frequency") {
      ui[[1]] <- checkboxInput(sprintf('%s.log', boxid), 'Use Zipf Scale', 1)
      ui[[2]] <- checkboxGroupInput(sprintf('%s.opt', boxid), 'Corpora',
                                    c('BNC (written)'='bnc_w', 'BNC (spoken)'='bnc_s', 'SUBTLEX-UK'='suk', 'SUBTLEX-US'='sus'),
                                    c('bnc_w', 'bnc_s', 'suk', 'sus'),
                                    inline=T)
    } else if(vtype == "Part of Speech") {
      ui[[1]] <- radioButtons(sprintf('%s.opt', boxid), 'Corpus',
                              c('SUBTLEX-UK'='suk',
                                'BNC (written)'='bnc_w',
                                'BNC (spoken)'='bnc_s',
                                'English Lexicon Project (ELP)'='elp'),
                              selected='suk',
                              inline=T)
    } else if(vtype == "Bigram Probability") {
      ui[[1]] <- checkboxGroupInput(sprintf('%s.opt', boxid), 'Corpora',
                                    c('BNC (written)'='bnc.wbg', 'BNC (spoken)'='bnc.sbg', 'SUBTLEX-UK'='subtlex_uk.bg', 'SUBTLEX-US'='subtlex_us.bg'),
                                    c('bnc.wbg', 'bnc.sbg', 'subtlex_uk.bg', 'subtlex_us.bg'),
                                    inline=T)
    } else if(vtype == "Orthographic Neighbourhood") {
      ui[[1]] <- checkboxInput(sprintf('%s.log', boxid), 'Log Transform', 1)
      ui[[2]] <- radioButtons(sprintf('%s.opt', boxid), 'Measure',
                              c('Orthographic Levenshtein Distance 20 (OLD20)'='old20', "Coltheart's N"='cn'),
                              'old20',
                              inline=T)
    } else if(vtype == "Syllables") {
      ui[[1]] <- radioButtons(sprintf('%s.opt', boxid), 'Source(s)',
                              c('CMU Pronouncing Dictionary'='cmu', 'eSpeak Transcriptions'='espeak'),
                              'cmu',
                              inline=T)
    } else if(vtype == "Phonemes") {
      ui[[1]] <- radioButtons(sprintf('%s.opt', boxid), 'Source(s)',
                              c('CMU Pronouncing Dictionary'='cmu', 'eSpeak Transcriptions'='espeak'),
                              'cmu',
                              inline=T)
    } else if (vtype == "Rhyme") {
      ui[[1]] <- radioButtons(sprintf('%s.opt', boxid), 'Source(s)',
                              c('CMU Pronouncing Dictionary'='cmu', 'eSpeak Transcriptions'='espeak'),
                              'cmu',
                              inline=T)
    } else if(vtype == "Phonological Neighbourhood") {
      ui[[1]] <- checkboxInput(sprintf('%s.log', boxid), 'Log Transform', 1)
      ui[[2]] <- radioButtons(sprintf('%s.source', boxid), 'Source(s)',
                              c('CMU Pronouncing Dictionary'='cmu', 'eSpeak Transcriptions'='espeak'),
                              'cmu',
                              inline=T)
      ui[[3]] <- radioButtons(sprintf('%s.opt', boxid), 'Measure',
                              c('Phonological Levenshtein Distance 20 (PLD20)'='pld20', "Coltheart's N"='cn'),
                              'pld20',
                              inline=T)
    } else if(vtype == "Number of Pronunciations") {
      ui[[1]] <- radioButtons(sprintf('%s.opt', boxid), 'Source(s)',
                              c('CMU Pronouncing Dictionary'='cmu'),
                              'cmu',
                              inline=T)
    } else if(vtype == "Familiarity") {
      ui[[1]] <- checkboxGroupInput(sprintf('%s.opt', boxid), 'Source(s)',
                                    c('Glasgow Norms'='gn', 'Clark and Paivio (2004)'='cp'),
                                    selected='gn',
                                    inline=T)
    } else if(vtype == "Age of Acquisition") {
      ui[[1]] <- checkboxGroupInput(sprintf('%s.opt', boxid), 'Source(s)',
                                    c('Kuperman et al. (2012)'='kuperman', 'Glasgow Norms'='gn', 'Brysbaert & Biemiller (2017)'='bb'),
                                    selected='kuperman',
                                    inline=T)
    } else if(vtype == "Concreteness") {
      ui[[1]] <- checkboxGroupInput(sprintf('%s.opt', boxid), 'Source(s)',
                                    c('Brysbaert et al. (2014)'='brysbaert', 'Glasgow Norms'='gn'),
                                    selected='brysbaert',
                                    inline=T)
    } else if(vtype == "Imageability") {
      ui[[1]] <- checkboxGroupInput(sprintf('%s.opt', boxid), 'Source(s)',
                                    c('Glasgow Norms'='gn', 'Clark and Paivio (2004)'='cp'),
                                    selected='gn',
                                    inline=T)
    } else if(vtype == "Arousal") {
      ui[[1]] <- checkboxGroupInput(sprintf('%s.opt', boxid), 'Source(s)',
                                    c('Warriner et al. (2013)'='warriner', 'Glasgow Norms'='gn'),
                                    selected='warriner',
                                    inline=T)
    } else if(vtype == "Valence") {
      ui[[1]] <- checkboxGroupInput(sprintf('%s.opt', boxid), 'Source(s)',
                                    c('Warriner et al. (2013)'='warriner', 'Glasgow Norms'='gn'),
                                    selected='warriner',
                                    inline=T)
    } else if(vtype == "Dominance") {
      ui[[1]] <- checkboxGroupInput(sprintf('%s.opt', boxid), 'Source(s)',
                                    c('Warriner et al. (2013)'='warriner', 'Glasgow Norms'='gn'),
                                    selected='warriner',
                                    inline=T)
    } else if(vtype == "Semantic Size") {
      ui[[1]] <- checkboxGroupInput(sprintf('%s.opt', boxid), 'Source(s)',
                                    c('Glasgow Norms'='gn'),
                                    selected='gn',
                                    inline=T)
    } else if(vtype == "Semantic Gender") {
      ui[[1]] <- checkboxGroupInput(sprintf('%s.opt', boxid), 'Source(s)',
                                    c('Glasgow Norms'='gn'),
                                    selected='gn',
                                    inline=T)
    } else if(vtype == "Humour") {
      ui[[1]] <- checkboxGroupInput(sprintf('%s.opt', boxid), 'Source(s)',
                                    c('Engelthaler & Hills (2018)'='eh'),
                                    selected='eh',
                                    inline=T)
    } else if (vtype == "Word Prevalence") {
      ui[[1]] <- checkboxGroupInput(sprintf('%s.opt', boxid), 'Source(s)',
                                    c('Brysbaert et al. (2018)'='brysbaert'),
                                    selected='brysbaert',
                                    inline=T)
    } else if (vtype == "Proportion Known") {
      ui[[1]] <- checkboxGroupInput(sprintf('%s.opt', boxid), 'Source(s)',
                                    c('Brysbaert et al. (2018)'='brysbaert'),
                                    selected='brysbaert',
                                    inline=T)
    } else if(vtype == "Lexical Decision Response Time") {
      ui[[1]] <- checkboxGroupInput(sprintf('%s.opt', boxid), 'Source(s)',
                                    c('British Lexicon Project (BLP)'='blp', 'English Lexicon Project (ELP)'='elp'),
                                    selected='blp',
                                    inline=T)
    } else if(vtype == "Lexical Decision Accuracy") {
      ui[[1]] <- checkboxGroupInput(sprintf('%s.opt', boxid), 'Source(s)',
                                    c('British Lexicon Project (BLP)'='blp', 'English Lexicon Project (ELP)'='elp'),
                                    selected='blp',
                                    inline=T)
    } else if(vtype == "Custom Variable") {
      customopts <- vis.opt.2.source(vtype, visualise.opts())
      customopts <- gsub("custom.", "", customopts)
      ui[[1]] <- checkboxGroupInput(sprintf('%s.opt', boxid), 'Source(s)',
                                    customopts,
                                    selected = customopts[1],
                                    inline=T)
    }
    
    ui
    
  }
  
  
}


controlfor_UI_sliders <- function(vtype, boxid, box_opt, box_log, lexops_df, toleranceUIopt="slider") {
  
  ui <- NULL
  
  # Categorical Variables
  if (vtype %in% c("Part of Speech", "Rhyme")) {
    
    # placeholder to maintain consistency with comparible functions
    # (splitby and filterby)
    
  } else if (length(box_opt)>=1 | vtype=="Length") {
    # Numerical Variables
    
    get_rowmeans <- function(column, df) { rowMeans(select(df, one_of(column)), dims=1, na.rm=T) }
    
    # defaults
    slider.range <- c(1, 10)
    slider.def_val <- c(4, 6)
    slider.step <- 0.5
    
    # variable-specific slider settings
    if (vtype == "Word Frequency") {
      if (box_log) {
        slider.range <- c(-1, 1)
        slider.def_val <- c(-0.2, 0.2)
        slider.step <- 0.1
      } else {
        slider.range <- c(-10000, 10000)
        slider.def_val <- c(-1000, 1000)
        slider.step <- 50
      }
    } else if (vtype=="Length") {
      slider.range <- c(-5, 5)
      slider.def_val <- c(0, 0)
      slider.step <- 1
    } else if (vtype=="Bigram Probability") {
      slider.range <- c(-0.01, 0.01)
      slider.def_val <- c(-0.002, 0.002)
      slider.step <- 0.001
    } else if (vtype=="Orthographic Neighbourhood") {
      if (all(box_opt=="old20")) {
        if (box_log) {
          slider.range <- c(-0.75, 0.75)
          slider.def_val <- c(-0.1, 0.1)
          slider.step <- 0.05
        } else {
          slider.range <- c(-5, 5)
          slider.def_val <- c(-1, 1)
          slider.step <- 0.1
        }
      } else if (all(box_opt=="cn")) {
        if (box_log) {
          slider.range <- c(-1.5, 1.5)
          slider.def_val <- c(-0.2, 0.2)
          slider.step <- 0.05
        } else {
          slider.range <- c(-10, 10)
          slider.def_val <- c(-1, 1)
          slider.step <- 1
        }
      }
    } else if (vtype=="Syllables") {
      slider.range <- c(-5, 5)
      slider.def_val <- c(0, 0)
      slider.step <- 1
    } else if (vtype=="Phonemes") {
      slider.range <- c(-5, 5)
      slider.def_val <- c(0, 0)
      slider.step <- 1
    } else if (vtype=="Phonological Neighbourhood") {
      if (all(box_opt=="pld20")) {
        if (box_log) {
          slider.range <- c(-0.75, 0.75)
          slider.def_val <- c(-0.1, 0.1)
          slider.step <- 0.05
        } else {
          slider.range <- c(-5, 5)
          slider.def_val <- c(-1, 1)
          slider.step <- 0.1
        }
      } else if (all(box_opt=="cn")) {
        if (box_log) {
          slider.range <- c(-1.5, 1.5)
          slider.def_val <- c(-0.2, 0.2)
          slider.step <- 0.05
        } else {
          slider.range <- c(-10, 10)
          slider.def_val <- c(-1, 1)
          slider.step <- 1
        }
      }
    } else if (vtype=="Number of Pronunciations") {
      slider.range <- c(-3, 3)
      slider.def_val <- c(0, 0)
      slider.step <- 1
    } else if (vtype %in% c("Familiarity", "Imageability", "Semantic Size", "Semantic Gender", "Humour", "Dominance", "Arousal", "Valence")) {
      slider.range <- c(-1.5, 1.5)
      slider.def_val <- c(-0.3, 0.3)
      slider.step <- 0.1
    } else if (vtype == "Concreteness") {
      slider.range <- if (all(box_opt=="brysbaert")) c(-1, 1) else c(-1.5, 1.5)
      slider.def_val <- if (all(box_opt=="brysbaert")) c(-0.2, 0.2) else c(-0.3, 0.3)
      slider.step <- 0.1
    } else if (vtype == "Age of Acquisition") {
      slider.range <- if (all(box_opt=="bb")) c(-12, 12) else if (all(box_opt=="kuperman")) c(-5, 5) else c(-1.5, 1.5)
      slider.def_val <- if (all(box_opt=="bb")) c(-1, 1) else if (all(box_opt=="kuperman")) c(-1, 1) else c(-0.3, 0.3)
      slider.step <- if (all(box_opt=="bb")) 1 else 0.1
    } else if (vtype == "Word Prevalence") {
      slider.range <- c(-1.5, 1.5)
      slider.def_val <- c(-0.5, 0.5)
      slider.step <- 0.1
    } else if (vtype == "Proportion Known") {
      slider.range <- c(-0.5, 0.5)
      slider.def_val <- c(-0.02, 0.02)
      slider.step <- 0.01
    } else if (vtype == "Lexical Decision Response Time") {
      if (length(box_opt)==1) {
        slider.range <- c(-500, 500)
        slider.def_val <- c(-100, 100)
        slider.step <- 10
      } else {
        slider.range <- c(-1.5, 1.5)
        slider.def_val <- c(-0.3, 0.3)
        slider.step <- 0.1
      }
    } else if (vtype == "Lexical Decision Accuracy") {
      slider.range <- c(-0.5, 0.5)
      slider.def_val <- c(-0.1, 0.1)
      slider.step <- 0.01
    } else if (vtype == "Custom Variable") {
      cn <- corpus_recode(box_opt, viscat2prefix(vtype))
      if (length(box_opt)!=1) {
        lexops_df[cn] <- lapply(lexops_df[cn], scale)
      }
      xval <- get_rowmeans(cn, lexops_df)
      fl <- floor(min(xval, na.rm=T))
      ce <- ceiling(max(xval, na.rm=T))
      fc_dist <- abs(ce-fl)
      slider.range <- c(-fc_dist/4, fc_dist/4)
      slider.step <- case_when(
        diff(slider.range) >= 10 ~ 1,
        diff(slider.range) >= 1 & diff(slider.range) < 10 ~ 0.1,
        diff(slider.range) < 1 ~ 0.01
      )
      slider.range <- case_when(
        diff(slider.range) >= 10 ~ c(floor(slider.range[1]), ceiling(slider.range[2])),
        diff(slider.range) >= 1 & diff(slider.range) < 10 ~ c(floor_dec(slider.range[1], 1), ceiling_dec(slider.range[2], 1)),
        diff(slider.range) < 1 ~ c(floor_dec(slider.range[1], 2), ceiling_dec(slider.range[2], 2))
      )
      slider.def_val <- c(-slider.step, slider.step)
    }
    
    # build sliders
    if (vtype != "(None)") {
      sl_val <- slider.def_val
      
      if (toleranceUIopt=="slider") {
        ui <- sliderInput(sprintf("%s_sl", boxid),
                          label = "Tolerance Criteria",
                          min = slider.range[1],
                          max = slider.range[2],
                          value = sl_val,
                          step = slider.step)
      } else if (toleranceUIopt=="numericinput") {
        
        if (length(sl_val)==1) {
          sl_val <- c(0, sl_val)
        }
        
        ui <- fluidRow(
          column(6, numericInput(sprintf("%s_tol_lower", boxid),
                                 label = "Tolerance Lower Limit",
                                 max = 0,
                                 value = sl_val[1],
                                 step = slider.step)),
          column(6, numericInput(sprintf("%s_tol_upper", boxid),
                                 label = "Tolerance Upper Limit",
                                 min = 0,
                                 value = sl_val[2],
                                 step = slider.step))
        )
        
      }
    
    }
  }
  
  ui
}

controlfor_UI_vis <- function(vtype, boxid, box_opt, box_log, box_source, lexops_df, shade_list) {
  
  if (vtype != "(None)") {
    
    if (vtype == "Rhyme") {
      
      rhyme.plot("rhyme", pron_nr=1, df=lexops_df, boxtype="warning")
      
    } else if (vtype == "Part of Speech") {
      
      pos.plot(xname = corpus_recode(box_opt, "PoS"),
               selected=T,
               PoS = "all",
               df = lexops_df)
      
    } else {
      # numeric vtypes
      
      force.histogram <- F
      
      if (length(box_opt)==0 & !(vtype %in% c("Length"))) {
        error.plot("Select a Source", "warning")
      } else {
        
        get_rowmeans <- function(column, df) { rowMeans(select(df, one_of(column)), dims=1, na.rm=T) }
        
        if (vtype == "Word Frequency") {
          cn <- corpus_recode(box_opt, if(box_log){"Zipf"}else{"fpmw"})
          scaletext <- c("Less Frequent", "More Frequent")
        } else if (vtype == "Length") {
          cn <- "Length"
          scaletext <- c("Shorter", "Longer")
          force.histogram <- T
        } else if (vtype == "Bigram Probability") {
          cn <- corpus_recode(box_opt, viscat2prefix(vtype))
          scaletext <- viscat2scaletext(vtype)
        } else if (vtype == "Orthographic Neighbourhood") {
          cn <- corpus_recode(box_opt, "ON", logprefix=box_log)
          if (box_opt=="old20") scaletext <- c("Larger Neighbourhood", "Smaller Neighbourhood")
          if (box_opt=="cn") scaletext <- c("Smaller Neighbourhood", "Larger Neighbourhood")
          if (box_opt=="cn" & !box_log) force.histogram <- T
        } else if (vtype == "Phonological Neighbourhood") {
          cn <- corpus_recode_columns(box_opt, vtype, box_log, box_source)
          if (box_opt=="pld20") scaletext <- c("Larger Neighbourhood", "Smaller Neighbourhood")
          if (box_opt=="cn") scaletext <- c("Smaller Neighbourhood", "Larger Neighbourhood")
          if (box_opt=="cn" & !box_log) force.histogram <- T
        } else if (vtype == "Number of Pronunciations") {
          cn <- "CMU.PrN"
          scaletext <- c("Fewer", "More")
          force.histogram <- T
        } else if (vtype == "Lexical Decision Accuracy") {
          cn <- corpus_recode(box_opt, prefix="Accuracy")
          scaletext <- c("Less Accurate", "More Accurate")
        } else {
          box_log <- if (is.logical(box_log)) {box_log} else {F}
          box_source <- if(!is.null(box_source)) {box_source} else {box_opt}  # handle for when the source is stored under opt
          if ((vtype %in% c("Phonemes", "Syllables")) | (vtype=="Age of Acquisition" & all(box_opt=="bb"))) force.histogram <- T
          cn <- corpus_recode_columns(box_opt, vtype, box_log, phonological_source = box_source)
          if (length(box_opt)>1) lexops_df[cn] <- lapply(lexops_df[cn], scale)
          scaletext <- viscat2scaletext(vtype)
        }
        
        lexops_df$xval <- get_rowmeans(cn, lexops_df)
        random_val <- lexops_df %>%
          filter(!is.na(xval) & is.finite(xval)) %>%
          sample_n(1) %>%
          select(xval)
        random_val <- unlist(random_val[1], use.names=F)
        relative_shade_list <- shade_list + random_val
        
        dens.plot(x="xval", redline=random_val, shade=relative_shade_list, df=lexops_df, boxtype='warning', text.lowscale=scaletext[1], text.highscale=scaletext[2], force.histogram=force.histogram)
      }
      
    }
    
  } else {
    
    error.plot("Select a Variable", "warning")
    
  }
  
}

controlfor_UI_plotwarning <- function(vtype, boxid, boxopt, lexops_df) {
  
  if (vtype != "(None)") {
    
    if (!vtype %in% c("Part of Speech", "Rhyme")) {
      
      if (vtype == "Custom Variable") {
        
        cn <- corpus_recode(box_opt, viscat2prefix(vtype))
        if (!is.numeric(lexops_df$cn)) return(NULL)
        
      }
      
      return("Note: For variables which are controlled for, the red line position is sampled randomly for illustration.")
      
    }
    
  }
  
}

