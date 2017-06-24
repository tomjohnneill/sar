if [ $# -eq 0 ]; then
  docker-compose exec rails bash -c 'bundle exec rails s -p 3000 -b 0.0.0.0'
else
  docker-compose exec rails bash -c "$*"
fi
