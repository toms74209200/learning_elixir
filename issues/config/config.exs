import Config

config :issues,
  github_url: "https://api.github.com"

config :logger,
  compile_time_purge_level: :info

import_config "#{config_env()}.exs"
