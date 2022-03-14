zar_brms_formula <- function(name, formula) {
  command <- substitute(brms::brmsformula(formula))
  
  return(
    targets::tar_target_raw(
      name,
      command
    )
  )
}