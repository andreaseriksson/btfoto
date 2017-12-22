# class BackupWorker
#   include Sidekiq::Worker
#
#   def perform
#     root_path = Rails.root.to_s
#     folder = Time.now.strftime('%Y.%m.%d.%H.%M.%S')
#     file_name = 'backup.sql'
#
#     system("PGPASSWORD=#{ENV['BT_FOTO_DATABASE_PASSWORD']} pg_dump --format=tar --no-privileges -h db -U postgres btfoto_#{Rails.env} > #{root_path}/#{file_name}")
#
#     s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
#     obj = s3.bucket('codered-dbbackups').object("btfoto/#{folder}/#{file_name}")
#     obj.upload_file(file_name)
#
#     delete_old_files
#
#     File.delete(Rails.root.join(file_name))
#   end
#
#   private
#
#   def delete_old_files
#     s3 = Aws::S3::Resource.new
#     bucket = s3.bucket('codered-dbbackups')
#
#     list = bucket.objects.select { |obj| obj.key.first(6) == 'btfoto' }.map(&:key)
#     list.first(list.length > 10 ? list.length-10 : 0).each do |key|
#       bucket.object(key)&.delete
#     end
#   end
# end
