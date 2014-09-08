cron 'copy-prod-to-staging' do
  minute 5
  hour 8 # Server is in UTC, 8am UTC -> 12am
  command 'mongo --host mongo-rs/localhost --eval "db=db.getSiblingDB(\'octoblu-staging\'); db.dropDatabase(); db=db.getSiblingDB(\'admin\'); db.runCommand({copydb:1, fromdb:\'octoblu\', todb:\'octoblu-staging\'}); db=db.getSiblingDB(\'meshblu-staging\'); db.dropDatabase(); db=db.getSiblingDB(\'admin\'); db.runCommand({copydb:1, fromdb:\'meshblu\', todb:\'meshblu-staging\'});"'
  user    'root'
end

cron 'run-octoblu-migrations' do
  minute 5
  hour 9 # Server is in UTC, 9am UTC -> 1am
  command "cd /srv/www/octoblu_migrations_staging/current && MGRT_MONGODB_URI=mongodb://172.31.33.28,172.31.38.108:27017,172.31.32.97/meshblu-staging npm start"
  user    'root'
end
