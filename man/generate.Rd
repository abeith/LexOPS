% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generate.R
\name{generate}
\alias{generate}
\title{Generate stimuli}
\usage{
generate(df, n = 20, match_null = "first", stringCol = "string",
  condCol = NA)
}
\arguments{
\item{df}{A data frame that is the result from \code{control_for()} or \code{split_by()}.}

\item{n}{The number of strings per condition (default = 20). Set to \code{"all"} to generate as many as possible.}

\item{match_null}{The condition words should be matched to. Should be a string indicating condition (e.g. \code{"A1_B2_C1"}), or a string indicating one of the following options: "first" for the lowest condition (e.g. \code{"A1"} or \code{"A1_B1_C1_D1"}, etc.), "random" for randomly selected null condition each iteration, "balanced" for randomly ordered null conditions with (as close to as possible) equal number of selections for each condition.}

\item{stringCol}{The column containing the strings (default = \code{"string"}).}

\item{condCol}{Prefix with which the columns detailing the splits were labelled by \code{split_by()}. This is rarely needed (default = \code{NA}), as by default the function gets this information from \code{df}'s attributes.}
}
\value{
Returns the generated stimuli.
}
\description{
Generates the stimuli from the data frame after it has been passed through \code{split_by()}, and optionally, \code{control_for()}. Will generate \code{n} items per condition. If <\code{n} items can be generated, will generate as many as possible given the experiment's design. Can be reproducible with \code{set.seed()}.
}
\examples{

# Generate 20 words per condition, for design with 3 levels of syllables, controlled for frequency
lexops \%>\%
  split_by(list("Syllables.CMU", c(1, 3), c(4, 6), c(7, 20))) \%>\%
  control_for(list("Zipf.SUBTLEX_UK", c(-0.2, 0.2))) \%>\%
  generate(n = 20)

# Generate 2 levels of bigram probability, controlling for frequency and length
# (Note that the matching null is balanced across all stimuli)
lexops \%>\%
  dplyr::filter(PK.Brysbaert >= .75) \%>\%
  split_by(list("BG.SUBTLEX_UK", c(0.001, 0.003), c(0.009, 0.011))) \%>\%
  control_for(list("Zipf.SUBTLEX_UK", c(-0.2, 0.2))) \%>\%
  control_for("Length") \%>\%
  generate(n = 1000, match_null = "balanced")

# Generate stimuli for a concreteness x valence (2 x 3) design
# (Note that abstract, neutral is set as the matching null)
# (Also note that the data is filtered by proportion known to be >75\%)
lexops \%>\%
  split_by(list("CNC.Brysbaert", c(1, 2), c(4, 5))) \%>\%
  split_by(list("VAL.Warriner", c(1, 3), c(4.5, 5.5), c(7, 9))) \%>\%
  control_for(list("Zipf.SUBTLEX_UK", c(-0.25, 0.25))) \%>\%
  control_for("Length") \%>\%
  generate(n = 30, match_null = "A2_B2")

}
