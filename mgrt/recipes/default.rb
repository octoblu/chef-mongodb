include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end

  execute "/usr/local/bin/npm install" do
    cwd "#{deploy[:deploy_to]}/current"
  end

  execute "/usr/local/bin/npm start" do
    cwd "#{deploy[:deploy_to]}/current"
  end
end

cron 'run-octoblu-migrations' do
  minute 5
  hour 9 # Server is in UTC, 9am UTC -> 1am
  command "cd #{deploy[:deploy_to]}/current && MGRT_MONGODB_URI=#{ENV['MGRT_MONGODB_URI']} npm start"
  user    'root'
end
