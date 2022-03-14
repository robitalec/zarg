zar_brms <- function(name, formula, priors, data, sample_priors, chains = 4,
                     iter = 2000, cores = 1, save_model = NULL) {
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