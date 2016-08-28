# encoding: utf-8

##
# Backup Generated: my_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t my_backup [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://backup.github.io/backup
#
Model.new(:btfoto_backup, 'Description for my_backup') do
  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    db.name               = 'btfoto_production'
    db.username           = 'postgres'
    db.password           = ENV['BT_FOTO_DATABASE_PASSWORD']
    db.host               = '188.166.31.210'
    db.port               = 5432
  end

  ##
  # Amazon Simple Storage Service [Storage]
  #
  store_with S3 do |s3|
    # AWS Credentials
    s3.access_key_id     = ENV['AWS_ACCESS_KEY_ID']
    s3.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    s3.region            = ENV['AWS_REGION']
    s3.bucket            = 'codered-dbbackups'
    s3.path              = 'btfoto'
    s3.keep              = 5
    # s3.keep              = Time.now - 2592000 # Remove all backups older than 1 month.
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip
end
