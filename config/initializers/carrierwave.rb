CarrierWave.configure do |cfg|
  cfg.storage = :aws
  cfg.aws_bucket = ENV['aws_s3_bucket_name']
  cfg.aws_acl = 'private'
  cfg.aws_credentials = {
    access_key_id: ENV['aws_s3_access_key_id'],
    secret_access_key: ENV['aws_s3_secret_access_key'],
    region: ENV['aws_s3_region'],
  }
end