library(targets)
library(brms)

devtools::install()
library(zarg)

c(
  tar_target(
    scaled_data,
    scale(mtcars)
  ),
  zar_brms(
    cars,
    formula = mpg ~ hp,
    priors = c(prior(normal(-0.5, 0.2), class = 'b')),
    family = gaussian(),
    data = scaled_data,
    sample_priors = TRUE,
    chains = 4,
    iter = 2000,
    cores = 1,
    save_model = NULL
  )
)