#
# Cookbook Name:: nginx
# Recipe:: default
# Author:: AJ Christensen <aj@junglist.gen.nz>
#
# Copyright 2008, OpsCode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

script "npm install npm" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    npm install -g npm
  EOH
end

node[:deploy].each do |application, deploy|
  script "npm install" do
    interpreter "bash"
    user deploy[:user]
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
      npm install
    EOH
  end
end

