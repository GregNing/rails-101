worker_processes 2

listen '/home/apps/rails-101/shared/tmp/unicorn.sock'
pid 'tmp/pids/unicorn.pid'

stderr_path 'log/unicorn.error.log'
stdout_path 'log/unicorn.log'