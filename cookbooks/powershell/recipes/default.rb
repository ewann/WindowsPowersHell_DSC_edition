#
# Cookbook Name:: powershell
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#
# Cookbook Name:: powershell
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

if node[:platform].include?("ubuntu")
  if node[:platform_version].include?("16.04")
    package "Install libunwind8" do
      package_name 'libunwind8'
    end
    package "Install libicu55" do
      package_name 'libicu55'
    end
    remote_file "/var/tmp/omi-1.1.0.ssl_100.x64.deb" do
      #source "#{node[:mye_deb_source_url]}"
      source 'https://github.com/Microsoft/omi/releases/download/v1.1.0-0/omi-1.1.0.ssl_100.x64.deb'
      owner 'root'
      group 'root'
      mode '0755'
      use_conditional_get true
      use_etag true
      use_last_modified true #this no longer seems an issue: https://coderwall.com/p/xpz5ow/using-chef-s-remote_file-with-github-raw-content
      action :create
      #not_if { node['packages']["#{node[:mye_epng]}"]['version'] == "#{node[:mye_epvg]}" }
    end
    remote_file "/var/tmp/psrp-1.0.0-0.universal.x64.deb" do
      #source "#{node[:mye_deb_source_url]}"
      source 'https://github.com/PowerShell/psl-omi-provider/releases/download/v.1.0/psrp-1.0.0-0.universal.x64.deb'
      owner 'root'
      group 'root'
      mode '0755'
      use_conditional_get true
      use_etag true
      use_last_modified true #this no longer seems an issue: https://coderwall.com/p/xpz5ow/using-chef-s-remote_file-with-github-raw-content
      action :create
      #not_if { node['packages']["#{node[:mye_epng]}"]['version'] == "#{node[:mye_epvg]}" }
    end
    remote_file "/var/tmp/powershell_6.0.0-alpha.10-1ubuntu1.16.04.1_amd64.deb" do
      #source "#{node[:mye_deb_source_url]}"
      source 'https://github.com/PowerShell/PowerShell/releases/download/v6.0.0-alpha.10/powershell_6.0.0-alpha.10-1ubuntu1.16.04.1_amd64.deb'
      owner 'root'
      group 'root'
      mode '0755'
      use_conditional_get true
      use_etag true
      use_last_modified true #this no longer seems an issue: https://coderwall.com/p/xpz5ow/using-chef-s-remote_file-with-github-raw-content
      action :create
      #not_if { node['packages']["#{node[:mye_epng]}"]['version'] == "#{node[:mye_epvg]}" }
    end
    remote_file "/var/tmp/dsc-1.1.1-294.ssl_100.x64.deb" do
      #source "#{node[:mye_deb_source_url]}"
      source 'https://github.com/Microsoft/PowerShell-DSC-for-Linux/releases/download/v1.1.1-294/dsc-1.1.1-294.ssl_100.x64.deb'
      owner 'root'
      group 'root'
      mode '0755'
      use_conditional_get true
      use_etag true
      use_last_modified true #this no longer seems an issue: https://coderwall.com/p/xpz5ow/using-chef-s-remote_file-with-github-raw-content
      action :create
      #not_if { node['packages']["#{node[:mye_epng]}"]['version'] == "#{node[:mye_epvg]}" }
    end
    execute "install-omi" do
      command "dpkg -i /var/tmp/omi-1.1.0.ssl_100.x64.deb"
      action :run
    end
    execute "install-omi-psrp-server" do
      command "dpkg -i /var/tmp/psrp-1.0.0-0.universal.x64.deb"
      action :run
    end
    execute "install-powershell" do
      command "dpkg -i /var/tmp/powershell_6.0.0-alpha.10-1ubuntu1.16.04.1_amd64.deb"
      action :run
    end
    execute "install-powershell-dsc" do
      command "dpkg -i /var/tmp/dsc-1.1.1-294.ssl_100.x64.deb"
      action :run
    end
#sudo powershell "install-module nx -Force"

  end
#https://github.com/PowerShell/PowerShell/releases/tag/v6.0.0-alpha.10
#http://www.howtogeek.com/267858/how-to-install-microsoft-powershell-on-linux-or-os-x/

#http://www.systemcentercentral.com/day-7-install-dsc-providers-linux-ubuntu-12-04/
end
