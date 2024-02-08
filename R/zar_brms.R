#' zar_brms
#'
#' @param name 
#' @param formula 
#' @param prior 
#' @param data 
#' @param chains 
#' @param iter 
#' @param init
#' @param cores
#' @param save_model 
#' @param control
#'
#' @return
#' @export
#'
#' @examples
zar_brms <-
  function(name,
           formula,
           prior,
           family = NULL,
           data,
           chains = 4,
           iter = 2000,
           cores = 1,
           init = NULL,
           control = NULL,
           save_model = NULL,
           backend = getOption('brms.backend', 'cmdstanr'),
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
  if (is.null(family)) {
    family <- stats::gaussian()
  }
  name_deparse <- paste0(deparse(substitute(name)), '_brms')
  
  name_formula <- paste(name_deparse, 'formula', sep = '_')
  name_prior <- paste(name_deparse, 'prior', sep = '_')
  name_data <- paste(name_deparse, 'data', sep = '_')
  name_sample_prior <- paste(name_deparse, 'sample_prior', sep = '_')
  name_stancode <- paste(name_deparse, 'stancode', sep = '_')
  name_sample <- paste(name_deparse, 'sample', sep = '_')
  
  
  command_formula <- substitute(brms::brmsformula(formula))
  command_prior <- substitute(prior)
  command_data <- substitute(data)
  command_stancode <- substitute(
    brms::make_stancode(
      formula = formula,
      data = data,
      prior = prior,
      family = family
    ),
    env = list(
      formula = as.symbol(name_formula),
      prior = as.symbol(name_prior),
      data = as.symbol(name_data),
      family = family
    ))
  env_sample <- list(
    formula = as.symbol(name_formula),
    prior = as.symbol(name_prior),
    data = as.symbol(name_data),
    family = family,
    chains = chains,
    iter = iter,
    cores = cores,
    init = init,
    save_model = save_model,
    backend = backend
  )
  command_sample_prior <-  substitute(
    brms::brm(
      formula = formula,
      data = data,
      prior = prior,
      family = family,
      sample_prior = 'only',
      chains = chains,
      iter = iter,
      cores = cores,
      init = init,
      save_model = save_model,
      backend = backend
    ),
    env = env_sample
  )
  command_sample <- substitute(
    brms::brm(
      formula = formula,
      data = data,
      prior = prior,
      family = family,
      sample_prior = 'no',
      chains = chains,
      iter = iter,
      cores = cores,
      save_model = save_model,
      backend = backend
    ),
    env = env_sample
  )
  
  
  target_formula <- tar_target_raw(
    name = name_formula,
    command = command_formula,
    packages = packages,
    library = library,
    format = format,
    error = error,
    memory = memory,
    garbage_collection = garbage_collection,
    deployment = deployment,
    priority = priority,
    cue = cue
  )
  target_prior <- tar_target_raw(
    name = name_prior,
    command = command_prior,
    packages = packages,
    library = library,
    format = format,
    error = error,
    memory = memory,
    garbage_collection = garbage_collection,
    deployment = deployment,
    priority = priority,
    cue = cue
  )
  target_data <- tar_target_raw(
    name = name_data,
    command = command_data,
    packages = packages,
    library = library,
    format = format,
    error = error,
    memory = memory,
    garbage_collection = garbage_collection,
    deployment = deployment,
    priority = priority,
    cue = cue
  )
  target_sample_prior <- tar_target_raw(
    name = name_sample_prior,
    command = command_sample_prior,
    packages = packages,
    library = library,
    format = format,
    error = error,
    memory = memory,
    garbage_collection = garbage_collection,
    deployment = deployment,
    priority = priority,
    cue = cue
  )
  target_stancode <- tar_target_raw(
    name = name_stancode,
    command = command_stancode,
    packages = packages,
    library = library,
    format = format,
    error = error,
    memory = memory,
    garbage_collection = garbage_collection,
    deployment = deployment,
    priority = priority,
    cue = cue
  )
  target_sample <- tar_target_raw(
    name = name_sample,
    command = command_sample,
    packages = packages,
    library = library,
    format = format,
    error = error,
    memory = memory,
    garbage_collection = garbage_collection,
    deployment = deployment,
    priority = priority,
    cue = cue
  )
  
  
  
  
  
  return(
    list(
      target_formula,
      target_prior,
      target_data,
      target_sample_prior,
      target_stancode,
      target_sample
    )
  )
  
  
  # name_prior <- paste(name_deparse, 'prior', sep = '_')
  # name_sample_prior <- paste(name_deparse, 'sample_prior', sep = '_')
  # name_stancode <- paste(name_deparse, 'stancode', sep = '_')
  # name_sample <- paste(name_deparse, 'sample', sep = '_')
  
  # symbol_formula <- as.symbol(name_formula)
  
  # c(
    # zar_brms_formula(name_formula, substitute(formula))#,
    # zar_brms_prior(name_prior, prior),
    # zar_brms_sample_prior(name_sample_prior, symbol_formula, prior, data, chains, 
    #                        iter, cores, save_model)
  # )
  
}