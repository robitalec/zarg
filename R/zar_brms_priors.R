zar_brms_priors <- function(name, priors) {
  command <- substitute(priors)
  
  return(
    targets::tar_target_raw(
    name,
    command
    )
  )
}