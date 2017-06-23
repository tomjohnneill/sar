if [ $# -eq 0 ]; then
  docker-compose exec rails bash -c 'bundle exec rails s -p 3000'
else
  docker-compose exec rails bash -c "$*"
fi
