library(R6)

currencyEnum <- function() {
    list(GBP = "GBP", USD = "USD"))
}

Cost <- R6Class("Cost", 
  public = list(
    # Constructor method
    initialize = function(value, year, currency, base_currency) {
      self$value = value,
      self$year = year,
      self$currency = currencyEnum()[[currency]]
      self$base_currency = currencyEnum()[[base_currency]]
      if (is.null(self$currency) || is.null(self$base_currency)) {
        stop("Invalid currency")
      },
  convert_currency = function(to_currency) {
    if (!to_currency %in% private$currency_list) {
      stop("Invalid currency")
    }
    rate <- conversion_df[conversion_df$year == self$year &
                          conversion_df$from == self$currency &
                          conversion_df$to == self$to_currency, "rate"]
    self$value <- self$value * rate
    self$currency <- to_currency
    invisible(self)
  },
  currency_to_base_country = function() {
    self$convert_currency(self$base_currency)  
    invisible(self)
  },
  change_year = function(year) {
    temp_currency <- self$currency
    self$currency_to_base_country()
    self$inflate_value(year)
    self$convert_currency(temp_currency)
    invisible(self)
  },
  inflate_value = function(to_year) {
    to_cost <- self$value
    for (i in self$year:(to_year - 1)) {
      rate <- inflation_df[inflation_df$year == i, "rate"]
      to_cost <- to_cost * (1 + rate)
    }
    self$value <- to_cost
    self$year <- year
    invisible(self)
  },
  inflate_next_year = function() {
    self$inflate_value(self$year + 1)
  },
  get_value = function() self$value,
  get_currency = function() self$currency
  ),
  private = list(
    currency_list = c("GBP", "USD")
  )
)

mycost <- Cost$new()

mycost$get_value()
mycost$convert_currency("USD")
mycost$get_currency()

mycost$currency_to_base_country()
mycost$get_currency()

mycost$inflate_value(2020)
mycost$get_value()

mycost$change_year(2020)
mycost$get_value()
