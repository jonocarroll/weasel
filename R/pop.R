#' Pop the first element in-place
#'
#' @param x 'stack' from which a value should be popped
#'
#' @return the popped first element of `x`
#'
#' @details This dispatches based on the `class()` of `x`. A macro
#' is then used to redefine `x` in the `parent.frame()` such that the
#' first element (as defined in that `class`) is removed in-place. This first
#' element is returned.
#'
#' @export
pop <- function(x) {
  UseMethod("pop")
}

#' @export
pop.default <- gtools::defmacro(x, expr = {
  ret <- x[1]
  x <- x[-1]
  ret
})

#' @export
pop.data.frame <- gtools::defmacro(x, expr = {
  ret <- x[1, , drop = FALSE]
  x <- x[-1, ]
  ret
})

#' @export
pop.list <- gtools::defmacro(x, expr = {
  ret <- x[[1]]
  x <- x[-1]
  ret
})
