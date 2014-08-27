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

  OpsWorks::NodejsConfiguration.npm_install(application, node[:deploy][application], release_path, node[:opsworks_nodejs][:npm_install_options])

  ruby_block "mgrt #{application}" do
    block do
      Chef::Log.info("mgrt")
      Chef::Log.info(`mgrt up --storage mongo-storage.js`)
      $? == 0
    end
  end

end

