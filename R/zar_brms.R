#' zar_brms
#'
#' @param name 
#' @param formula 
#' @param priors 
#' @param data 
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
           family = NULL,
           data,
           chains = 4,
           iter = 2000,
           cores = 1,
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
  name_deparse <- deparse(substitute(name))
  
  name_formula <- paste(name_deparse, 'formula', sep = '_')
  name_priors <- paste(name_deparse, 'priors', sep = '_')
  name_data <- paste(name_deparse, 'data', sep = '_')
  name_sample_priors <- paste(name_deparse, 'sample_priors', sep = '_')
  name_stancode <- paste(name_deparse, 'stancode', sep = '_')
  name_sample <- paste(name_deparse, 'sample', sep = '_')
  
  
  command_formula <- substitute(brms::brmsformula(formula))
  command_priors <- substitute(priors)
  command_data <- substitute(data)
  command_stancode <- substitute(
    make_stancode(
      formula = formula,
      data = data,
      prior = priors,
      family = if(is.null(family)) gaussian() else family
    ),
    env = list(
      formula = as.symbol(name_formula),
      priors = as.symbol(name_priors),
      data = as.symbol(name_data),
      family = family
    ))
  env_sample <- list(
    formula = as.symbol(name_formula),
    priors = as.symbol(name_priors),
    data = as.symbol(name_data),
    family = if(is.null(family)) gaussian() else family,
    chains = chains,
    iter = iter,
    cores = cores,
    save_model = save_model,
    backend = backend
  )
  command_sample_priors <-  substitute(
    brms::brm(
      formula = formula,
      data = data,
      prior = priors,
      sample_prior = 'only',
      chains = chains,
      iter = iter,
      cores = cores,
      save_model = save_model,
      backend = backend
    ),
    env = env_sample
  )
  command_sample <- substitute(
    brm(
      formula = formula,
      data = data,
      prior = priors,
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
  target_priors <- tar_target_raw(
    name = name_priors,
    command = command_priors,
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
  target_sample_priors <- tar_target_raw(
    name = name_sample_priors,
    command = command_sample_priors,
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
      target_priors,
      target_data,
      target_sample_priors,
      target_stancode,
      target_sample
    )
  )
  
  
  # name_priors <- paste(name_deparse, 'priors', sep = '_')
  # name_sample_priors <- paste(name_deparse, 'sample_priors', sep = '_')
  # name_stancode <- paste(name_deparse, 'stancode', sep = '_')
  # name_sample <- paste(name_deparse, 'sample', sep = '_')
  
  # symbol_formula <- as.symbol(name_formula)
  
  # c(
    # zar_brms_formula(name_formula, substitute(formula))#,
    # zar_brms_priors(name_priors, priors),
    # zar_brms_sample_priors(name_sample_priors, symbol_formula, priors, data, chains, 
    #                        iter, cores, save_model)
  # )
  
}