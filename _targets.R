library(targets)
library(brms)
library(data.table)
library(zarg)

options('brms.threads' = 2)

c(
  tar_target(
    cars,
    data.table(mtcars)
  ),
  tar_target(
    scaled_cars,
    cars[, c('scaled_mpg', 'scaled_hp') := .(scale(mpg), scale(hp))]
  ),
  zar_brms(
    cars,
    formula = scaled_mpg ~ scaled_hp,
    prior = c(prior(normal(0, 0.5), class = 'b'),
              prior(normal(0, 0.5), class = 'Intercept'),
              prior(exponential(1), class = 'sigma')),
    family = gaussian(),
    data = scaled_cars,
    chains = 4,
    iter = 2000,
    cores = 1,
    control = list(adapt_delta = 0.9),
    save_model = NULL
  )
)