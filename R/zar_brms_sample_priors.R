zar_brms_sample_priors <- function(name, name_formula, name_priors, data_deparse, chains, iter, 
                                   cores, save_model) {
  command <- substitute(
    brms::brm(
      formula = formula,
      data = data,
      prior = priors,
      sample_prior = 'only',
      chains = chains,
      iter = iter,
      cores = cores,
      save_model = save_model
    ),
    env = list(
      formula = as.symbol(name_formula),
      priors = as.symbol(name_priors),
      data = as.symbol(data_deparse)
    )
  )
  
  return(
    targets::tar_target_raw(
      name,
      command
    )
  )
  
}