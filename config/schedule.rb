job_type :rake, "cd :path && :environment_variable=:environment bundle exec rake :task --silent :output"

every 1.hour do
  rake "db:destroy_outdated_statuses"
end
