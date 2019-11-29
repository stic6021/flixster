Rails.configuration.stripe = {
  :publishable_key => ENV['stripe_publishable_key_test'],
  :secret_key      => ENV['stripe_secret_key_test']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]