context('test-zar_brms')

data_name <- 'mtcars'
zb <- zar_brms(
  mtcars,
  formula = mpg ~ hp,
  prior = c(prior(normal(-0.5, 0.2), class = 'b')),
  family = gaussian(),
  data = cars_data,
  chains = 4,
  iter = 2000,
  cores = 1,
  # control = 0.8,
  save_model = NULL
)

