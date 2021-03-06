library(targets)
library(brms)

devtools::install()
library(zarg)

c(
  tar_target(
    cars_data,
    mtcars
  ),
  zar_brms(
    cars,
    formula = mpg ~ hp,
    prior = c(prior(normal(-0.5, 0.2), class = 'b')),
    family = gaussian(),
    data = cars_data,
    chains = 4,
    iter = 2000,
    cores = 1,
    save_model = NULL
  )
)