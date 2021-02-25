# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :livewords,
  ecto_repos: [Livewords.Repo]

# Configures the endpoint
config :livewords, LivewordsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pd0Hv4bFxdfswJ09Dd2bxTHqzMEjMGsR0JN/qDwibhz6pbOKH6MfzwVy1EHP8JSs",
  render_errors: [view: LivewordsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Livewords.PubSub,
  live_view: [signing_salt: "7Vig/+hQ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
