#' Push an element to an object in-place
#'
#' @param x 'stack' into which a value should be pushed
#' @param y value (matching the class of `x`) to be pushed on to `x`
#'
#' @return the updated object `x`, invisibly
#'
#' @details This dispatches based on the `class()` of `x`. A macro
#' is then used to redefine `x` in the `parent.frame()` such that `y` is inserted
#' as the first element in-place.
#'
#' @export
push <- function(x, y) {
  UseMethod("push")
}

#' @export
push.default <- gtools::defmacro(x, y, expr = {
  x <- c(y, x)
})

#' @export
push.data.frame <- gtools::defmacro(x, y, expr = {
  stopifnot(inherits(x, "data.frame"))
  x <- rbind(y, x)
})

#' @export
push.list <- gtools::defmacro(x, y, expr = {
  stopifnot(inherits(y, "list"))
  x <- c(y, x)
})
