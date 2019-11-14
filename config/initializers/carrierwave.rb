CarrierWave.configure do |cfg|
  cfg.fog_provider = 'fog/aws'
  cfg.fog_public = false
  cfg.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['aws_s3_access_key_id'],
    aws_secret_access_key: ENV['aws_s3_secret_access_key'],
  }
  cfg.fog_directory = ENV['aws_s3_bucket_name']
end