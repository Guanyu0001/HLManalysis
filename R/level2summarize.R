#' Use dplyr to calculate level 2 statistics
#'
#' @description This function is a wrapper for the [dplyr::summarize()] function from the dplyr package. The function is fortified to handle the missing values (NA), and it can provide a summary table with many descriptive statistics for a variable grouped by a specify categorical variable. In this case, this function can be used in multilevel models, and provide the statistics for the level 2 units (e.g. the groups).
#'
#' @param data A data frame, or a data frame extension (e.g. a tibble).
#' @param a The name of the column from the data frame to group by.
#' @param b The name of the column from the data frame to be summarized.
#' @examples
#' # 1. A real dataset example
#' level2summarize(mtcars, am, mpg) # summarize mpg based on am
#'
#' # 2. A fake datseat example to show parameter a can be numeric or factor
#' a <- as.factor(c(rep(1, 10), rep(2, 10)))
#' b <- as.numeric(c(rep(1, 10), rep(-1, 10))) # a as numeric
#' data1 <- data.frame(a, b)
#' level2summarize(data1, a, b)
#' a <- as.numeric(c(rep(1, 10), rep(2, 10)))
#' b <- as.numeric(c(rep(1, 10), rep(-1, 10))) # a as factor
#' data1 <- data.frame(a, b)
#' level2summarize(data1, a, b)
#' @seealso [dplyr::summarize()]
#' @importFrom magrittr "%>%"
#' @importFrom stats "sd"
#' @importFrom stats "median"
#'
#' @return A summary table with sample size, number of missing value, mean, median, standard deviation, minimum, and maximum for the given column b grouped by the column a.
#' @md
#' @export





level2summarize <- function(data, a, b) {
  if (ncol(data) == 0 | nrow(data) == 0 | !is.data.frame(data)) {
    stop("\n A none empty data frame is required. \n Your input is a ", nrow(data), " X ", ncol(data), " ", class(data), ".")
  }

  dv <- eval(substitute(b), data)
  if (!is.numeric(dv)) {
    stop("\n A numeric variable should be used for calculation. \n Your input is a ", class(dv), " variable.")
  }

  summary_table <- data %>%
    dplyr::group_by({{ a }}) %>%
    dplyr::summarize(
      n = sum(!is.na({{ b }})),
      missing = sum(is.na({{ b }})),
      mean = mean({{ b }}, na.rm = T),
      median = median({{ b }}, na.rm = T),
      sd = sd({{ b }}, na.rm = T),
      min = min({{ b }}, na.rm = T),
      max = max({{ b }}, na.rm = T)
    )
  return(summary_table)
}
