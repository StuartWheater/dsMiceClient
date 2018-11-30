#'A convenience function for logging into an DataSHIELD cluster
#'
#'This function is called for its side effect to log into the
#'DataSHIELD cluster.
#'@param cluster Either \code{"recap"} or \code{"opal-demo"}. For \code{"recap"}
#'you should have set environmental variables \code{RECAP_DEFAULT},
#'\code{RECAP_TEST}, \code{RECAP_USER} and \code{RECAP_PW}.
#'@return A list.
#'@export
login <- function(cluster = c("recap", "opal-demo")) {

  cluster <- match.arg(cluster)

  if (cluster == "opal-demo") {
    logindata <- data.frame(
      server = paste0("s", 1:3),
      url = "https://opal-demo.obiba.org",
      user = "administrator",
      password = "password",
      table = paste0("datashield.CNSIM", 1:3))
    opals <- opal::datashield.login(logins = logindata,
                                    assign = TRUE)
    return(invisible(opals))
  }

  if (cluster == "recap") {

    logindata <- data.frame(
      server = c('recap-default', 'recap-test'),
      url = c(Sys.getenv("RECAP_DEFAULT"), Sys.getenv("RECAP_TEST")),
      user = Sys.getenv("RECAP_USER"),
      password = Sys.getenv("RECAP_PW"),
      table = c('imputation1.nhanes_top', 'imputation2.nhanes_bot'))

    opals <- opal::datashield.login(logins = logindata,
                                    assign = TRUE)
    return(invisible(opals))
  }
}
