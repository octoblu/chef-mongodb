include_recipe "cron_d"

cron_d 'copy-prod-to-staging' do
  command 'touch /tmp/copy-prod-to-staging'
  user    'root'
end
