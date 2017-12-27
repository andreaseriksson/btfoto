threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count

port ENV['PORT'] || 3000
environment ENV['RAILS_ENV'] || 'development'

plugin :tmp_restart
