class BackupWorker
  def self.perform
    exec("backup perform --trigger btfoto_backup")
  end
end
