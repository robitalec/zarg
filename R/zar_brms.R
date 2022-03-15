#' zar_brms
#'
#' @param name 
#' @param formula 
#' @param priors 
#' @param data 
#' @param sample_priors 
#' @param chains 
#' @param iter 
#' @param cores 
#' @param save_model 
#'
#' @return
#' @export
#'
#' @examples
zar_brms <-
  function(name,
           formula,
           priors,
           data,
           sample_priors = TRUE,
           chains = 4,
           iter = 2000,
           cores = 1,
           save_model = NULL,
           packages = targets::tar_option_get("packages"),
           library = targets::tar_option_get("library"),
           format = "qs",
           error = targets::tar_option_get("error"),
           memory = targets::tar_option_get("memory"),
           garbage_collection = targets::tar_option_get("garbage_collection"),
           deployment = targets::tar_option_get("deployment"),
           priority = targets::tar_option_get("priority"),
           cue = targets::tar_option_get("cue")
  ) {
  name_deparse <- deparse(substitute(name))
  data_deparse <- deparse(substitute(data))
  
  name_formula <- paste(name_deparse, 'formula', sep = '_')
  name_priors <- paste(name_deparse, 'priors', sep = '_')
  name_sample_priors <- paste(name_deparse, 'sample_priors', sep = '_')
  name_stancode <- paste(name_deparse, 'stancode', sep = '_')
  name_sample <- paste(name_deparse, 'sample', sep = '_')
  
  c(
    zar_brms_formula(name_formula, formula),
    zar_brms_priors(name_priors, priors),
    zar_brms_sample_priors(name_sample_priors, formula, priors, data, chains, 
                           iter, cores, save_model),
  
}