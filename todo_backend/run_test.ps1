$container_id = docker ps | ?{$_ -match 'todo_backend-web'} | % { ($_ -split "  ")[0] }
cls
docker exec $container_id bundle exec rspec