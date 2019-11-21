data {
  int Nschools;
  real school_score[Nschools];
  real school_se[Nschools];
}

parameters {
  real mu;
  real<lower=0> sigma;
  real tau[Nschools];
}

transformed parameters {
  real t[Nschools];

  for (i in 1:Nschools) {
    t[i] = mu + sigma*tau[i];
  }
}

model {
  mu ~ normal(0, 20);
  sigma ~ normal(0, 20);

  tau ~ normal(0, 1); /* => t ~ N(mu, sigma)*/

  for (i in 1:Nschools) {
    school_score[i] ~ normal(t[i], school_se[i]);
  }
}
