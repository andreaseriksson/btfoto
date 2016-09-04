require 'aws-sdk'

class BackupService
  def self.perform
    root_path = Rails.root.to_s
    folder = Time.now.strftime('%Y.%m.%d.%M.%S')
    file_name = 'backup.sql'

    system("pg_dump --format=tar --no-privileges btfoto_#{Rails.env} > #{root_path}/#{file_name}")

    s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
    obj = s3.bucket('codered-dbbackups').object("btfoto/#{folder}/#{file_name}")
    obj.upload_file('backup.sql')

    File.delete(Rails.root.join(file_name))
  end
end
