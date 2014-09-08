cron 'copy-prod-to-staging' do
  minute 5
  hour 8 # Server is in UTC, 8am UTC -> 12am
  command 'mongo --host mongo-rs/localhost --eval "db=db.getSiblingDB(\'octoblu-staging\'); db.dropDatabase(); db=db.getSiblingDB(\'admin\'); db.runCommand({copydb:1, fromdb:\'octoblu\', todb:\'octoblu-staging\'}); db=db.getSiblingDB(\'meshblu-staging\'); db.dropDatabase(); db=db.getSiblingDB(\'admin\'); db.runCommand({copydb:1, fromdb:\'meshblu\', todb:\'meshblu-staging\'});"'
  user    'root'
end
