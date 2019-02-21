worker_processes 2

listen '/home/apps/rails-101/shared/tmp/unicorn.sock'
pid '/home/apps/rails-101/shared/tmp/pids/unicorn.pid'

stderr_path 'log/unicorn.error.log'
stdout_path 'log/unicorn.log'

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

check_client_connection false

before_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end
