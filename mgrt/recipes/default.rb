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

  env_vars = []

  deploy[:environment_variables].each do |name, value|
    env_vars << "#{name}=\"#{value}\""
  end

  execute "/usr/local/bin/npm install" do
    cwd "#{deploy[:deploy_to]}/current"
  end

  execute "/usr/bin/env #{env_vars.join(" ")} /usr/local/bin/npm start" do
    cwd "#{deploy[:deploy_to]}/current"
  end
end

