class BackupWorker
  def self.perform
    env_variables = %w(BT_FOTO_DATABASE_PASSWORD AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_REGION).map do |env_variable|
      "#{env_variable}=#{ENV[env_variable]}"
    end
    exec("#{env_variables.join(' ')} backup perform --trigger btfoto_backup")
  end
end
