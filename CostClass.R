library(R6)

Cost <- R6Class("Cost", 
  public = list(
    # Constructor method
    initialize = function(value, year, currency, base_currency) {
      self$value = value,
      self$year = year,
      if (currency %in% private$currency_list) {
        self$currency <- currency  
      } else {
        stop("Invalid currency")
      }
      if (base_currency %in% private$currency_list) {
        self$base_currency <- base_currency  
      } else {
        stop("Invalid currency")
      }},
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
  },
  get_value = function() self$value,
  get_currency = function() self$currency
  ),
  private = list(
    currency_list = c("GBP", "USD")
  )
)

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
