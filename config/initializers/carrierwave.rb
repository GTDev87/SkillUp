CarrierWave.configure do |config|
  #config.grid_fs_database = Mongoid::Config.sessions[:default][:database]
  #config.grid_fs_host = Mongoid::Config.sessions[:default][:hosts].first

  config.storage = :grid_fs

  # Storage access url
  config.grid_fs_access_url = "/upload/grid"
end