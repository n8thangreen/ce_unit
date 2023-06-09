library(R6)

Cost <- R6Class("Cost", list(
  value = 10,
  year = 2000,
  currency = "GBP",
  base_currency = "GBP",

  convert_currency = function(to_currency) {
    self$value <- self$value + 1
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
  inflate_value = function(year) {
    self$value <- self$value*(1 + 0.035)^(year - self$year)
    self$year <- year
    invisible(self)
  }
))

mycost <- Cost$new()

mycost$value
mycost$convert_currency("USD")
mycost$currency

mycost$currency_to_base_country()
mycost$currency

mycost$inflate_value(2020)
mycost$value

mycost$change_year(2020)
mycost$value
