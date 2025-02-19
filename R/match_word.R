#' Get suitable matches for a single word on one or several dimensions.
#'
#' Suggests strings that are suitable matches for a target string, based on
#' selected variables of a data frame.
#'
#' @param df A data frame to reorder, containing the target string (default = LexOPS::lexops).
#' @param target The target string
#' @param vars Can be a list of vars from df to match by, in the form list("numericVariable1Name", c("numericVariable2Name", -1.5, 3), "characterVariableName"). Numeric variables can include tolerances (as elements 2:3 of a vector). Numeric variables with no tolerances will be matched exactly.
#' @param stringCol The column containing the strings (default = "string")
#' @param filter Logical. If TRUE, matches outside the tolerances specified in vars are removed. If FALSE, a new column, matchFilter is calculated indicating whether or not the string is within all variables' tolerances. (Default = TRUE.)
#' @return Returns data frame based on `df`. If `filter` == TRUE, will only contain matches. If `filter` == FALSE, will be the original `df` object, with a new column, "matchFilter".
#' @examples
#'
#' # Match by number of syllables exactly
#' lexops %>%
#'   match_word("thicket", "Syllables.CMU")
#'
#' # Match by number of syllables exactly, but keep all entries in the original dataframe
#' lexops %>%
#'   match_word("thicket", "Syllables.CMU", filter = FALSE)
#'
#' # Match by number of syllables exactly, and rhyme
#' lexops %>%
#'   match_word("thicket", list("Syllables.CMU", "Rhyme.CMU"))
#'
#' # Match by length exactly, and closely by frequency (within 0.2 Zipf either way)
#' lexops %>%
#'   match_word("thicket", list("Length", c("Zipf.SUBTLEX_UK", -0.2, 0.2)))
#'
#' @seealso \code{\link{lexops}} for the default data frame and associated variables.
#'
#' @export

match_word <- function(df = LexOPS::lexops, target, vars, stringCol = "string", filter = TRUE) {
  # check the df is a dataframe
  if (!is.data.frame(df)) stop(sprintf("Expected df to be of class data frame, not %s", class(df)))
  # check this dataframe doesn't include a column called Euclidean.Distance; if it does, remove it and throw a warning
  if ("Euclidean.Distance" %in% colnames(df)) {
    warning('"Euclidean.Distance" column will be ignored, as this is overwritten by `match_word()`')
    df$Euclidean.Distance <- NULL
  }
  # check stringCol is a string
  if (!is.character(stringCol)) stop(sprintf("Expected stringCol to be of class string, not %s", class(stringCol)))
  # check target is a string
  if (!is.character(target)) stop(sprintf("Expected target to be of class string, not %s", class(target)))
  # check all variables in vars are in the dataframe
  varsPresent <- sapply(vars, function(listobj) listobj[1] %in% colnames(df))
  if (!all(varsPresent)) {
    stop(
      sprintf(
        "Missing %i variables in df:\n\t%s",
        length(vars[!varsPresent]),
        paste(sapply(vars[!varsPresent], function(listobj) listobj[1]), collapse="\n\t")
      )
    )
  }
  # check numeric and non-numeric variables are correctly specified
  varsIncorrectlySpecified <- sapply(vars, function(listObj) {
    (!is.numeric(df[[listObj[1]]]) & length(listObj)==3) | !(length(listObj) %in% c(1, 3))
  })
  if (any(varsIncorrectlySpecified)) {
    stop(
      sprintf(
        "%i variables misspecified:\n\t%s",
        length(vars[varsIncorrectlySpecified]),
        paste(sapply(vars[varsIncorrectlySpecified], function(listObj) {
          recodedError <- if (!length(listObj) %in% c(1, 3)) {
            sprintf("expected list object to be of length 1 (no tolerances) or 3 (with tolerances), not %i", length(listObj))
          } else if (!is.numeric(df[[listObj[[1]][1]]])) {
            "did not expect tolerances for non-numeric variable"
          }
          sprintf("%s - %s", listObj[1], recodedError)
        }), collapse="\n\t")
      )
    )
  }
  # check stringCol is a column in df
  if (!stringCol %in% colnames(df)) stop(sprintf("'%s' column not found in df", stringCol))
  # check target word in stringCol
  if (!target %in% df[[stringCol]]) stop(sprintf("'%s' not found in '%s' column of df", target, stringCol))

  # get the euclidean distance, and add as a new column, 2nd after the stringCol column
  vars_sans_tols <- sapply(vars, dplyr::first, USE.NAMES = FALSE)
  numeric_vars <- vars_sans_tols[sapply(df[, vars_sans_tols], is.numeric)]
  df <- df %>%
    dplyr::mutate(Euclidean.Distance = LexOPS::euc_dists(., target = target, vars = numeric_vars, stringCol = stringCol)) %>%
    dplyr::arrange(Euclidean.Distance) %>%
    dplyr::select(!!(dplyr::sym(stringCol)), Euclidean.Distance, dplyr::everything())

  # get the numeric and character tolerances relative to the target word
  numFilt <- lapply(vars, function(listObj) {
    if (is.numeric(df[[listObj[1]]])) {
      out <- listObj
      if (length(listObj) == 3) {
        out[2:3] <- as.numeric(out[2:3]) + df[[listObj[1]]][df[[stringCol]]==target]
      } else if (length(listObj) == 1) {
        out[2:3] <- df[[listObj[1]]][df[[stringCol]]==target]
      }
      return(out)
    }
  })
  numFilt[sapply(numFilt, is.null)] <- NULL  # remove NULL values (probably character filters)

  charFilt <- lapply(vars, function(listObj) {
    if (!is.numeric(df[[listObj[1]]])) {
      out <- listObj
      out[2] <- df[[listObj]][df[[stringCol]]==target]
      return(out)
    }
  })
  charFilt[sapply(charFilt, is.null)] <- NULL  # remove NULL values (probably numeric filters)

  # filter out words that don't fit the filters
  if (length(numFilt) > 0) {
    numOut <- numFilt %>%
      purrr::map(~df %>%
                   dplyr::filter(dplyr::between(
                     !!(dplyr::sym(.x[1])),
                     as.numeric(.x[2]),
                     as.numeric(.x[3])
                   ))) %>%
      purrr::reduce(dplyr::inner_join, by = colnames(df))
  }
  if (length(charFilt) > 0) {
    charOut <- charFilt %>%
      purrr::map(~df %>%
                   dplyr::filter(
                     !!(dplyr::sym(.x[1])) == as.character(.x[2])
                   )) %>%
      purrr::reduce(dplyr::inner_join, by = colnames(df))
  }

  # return the result
  if (length(numFilt) > 0 & length(charFilt) > 0) {
    out <- dplyr::inner_join(charOut, numOut, by = colnames(charOut))
  } else if (length(numFilt) > 0 & length(charFilt) == 0) {
    out <- numOut
  } else {
    out <- charOut
  }

  # if the filter argument is FALSE, return the original df, but with new column matchFilter
  if (!filter) {
    out <- dplyr::mutate(df, matchFilter = !!(dplyr::sym(stringCol)) %in% out[[stringCol]])
  }

  # remove the target word
  out <- dplyr::filter(out, !!(dplyr::sym(stringCol)) != target)

  # return the result
  out
}

# these should throw each of the possible errors

# LexOPS::lexops %>% match_word("thicket", list(c("Length", -1, 1), "Rhyme", c("unreal", 1)))
#
# LexOPS::lexops %>% match_word("thicket", list(c("Length", -1, 1), c("Rhyme.CMU", 1, 2), "Zipf.SUBTLEX_UK"))
#
# LexOPS::lexops %>% match_word("thicket", list(c("Length", 0, 0), c("Zipf.SUBTLEX_UK", -1.5)))
#
# LexOPS::lexops %>% match_word("111", list(c("Length", 0, 0), c("Zipf.SUBTLEX_UK", -1.5, 1.5)))
#
# LexOPS::lexops %>% match_word("thicket", list(c("Length", 0, 0), c("Zipf.SUBTLEX_UK", -1.5, 1.5)))
#
# LexOPS::lexops %>% match_word("thicket", list(c("Length", 0, 0), c("Zipf.SUBTLEX_UK", -1.5, 1.5)), df="hi")
#
# LexOPS::lexops %>% match_word(2, list(c("Length", 0, 0), c("Zipf.SUBTLEX_UK", -1.5, 1.5)), stringCol = "string")
#
# LexOPS::lexops %>% match_word("thicket", list(c("Length", 0, 0), c("Zipf.SUBTLEX_UK", -1.5, 1.5)), stringCol = 3*1)
#
# # these should work
#
# LexOPS::lexops %>% match_word("thicket", list(c("Zipf.SUBTLEX_UK", -0.2, 0.2)))
#
# LexOPS::lexops %>% match_word("thicket", list(c("Length", 0, 0)))
#
# LexOPS::lexops %>% match_word("thicket", list(c("Length", 0, 0), c("Zipf.SUBTLEX_UK", -0.2, 0.2)))
#
# LexOPS::lexops %>% match_word("thicket", list(c("Length", 0, 0), c("Zipf.SUBTLEX_UK", -0.2, 0.2), "Rhyme.eSpeak.br"))


