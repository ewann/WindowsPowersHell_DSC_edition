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
  if node[:platform_version].include?("14.04")
  #14.04 specific pre-reqs
    package "Install libicu52" do
      package_name 'libicu52'
      #this is a guess, based on http://packages.ubuntu.com/trusty/libicu52
    end
    remote_file "/var/tmp/powershell_6.0.0-alpha.12-1ubuntu1.14.04.1_amd64.deb" do
      #source "#{node[:mye_deb_source_url]}"
      source 'https://github.com/PowerShell/PowerShell/releases/download/v6.0.0-alpha.12/powershell_6.0.0-alpha.12-1ubuntu1.14.04.1_amd64.deb'
      owner 'root'
      group 'root'
      mode '0755'
      use_conditional_get true
      use_etag true
      use_last_modified true #this no longer seems an issue: https://coderwall.com/p/xpz5ow/using-chef-s-remote_file-with-github-raw-content
      action :create
      #not_if { node['packages']["#{node[:mye_epng]}"]['version'] == "#{node[:mye_epvg]}" }
    end
  end

  if node[:platform_version].include?("16.04")
  #16.04 specific pre-reqs
    package "Install libicu55" do
      package_name 'libicu55'
    end
    package "Install python-minimal" do
      #if python2 is not installed python isn't always
      #aliased to python3. This ensures a version of python is available
      #without any custom mappings.
      package_name 'python-minimal'
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
  end

  case node[:platform_version]
  #common prereqs
  when "16.04","14.04"
    package "Install libunwind8" do
      package_name 'libunwind8'
    end    
    package "Install libcurl4-openssl-dev" do
      #If this is missing, when we try:
      #Install-module nx
      #we get errors like:
      #PackageManagement\Install-Package : No match was found for the specified
      #search criteria and module name 'nx'. Try Get-PSRepository to see all
      # available registered module repositories
      #if its working we can expect something like:
      #Get-PSRepository
      #Name                      InstallationPolicy   SourceLocation
      #----                      ------------------   --------------
      #PSGallery                 Untrusted            https://www.powershellgallery.com/api/v2/
      #solution found on https://github.com/Microsoft/vsts-agent/issues/232
      package_name 'libcurl4-openssl-dev'
    end
    remote_file "/var/tmp/omi-1.1.0.ssl_100.x64.deb" do
      #20161106 currently same download for 14.04 & 16.04
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
  end

  execute "install-omi" do
    command "dpkg -i /var/tmp/omi-1.1.0.ssl_100.x64.deb"
    action :run
  end
  execute "install-omi-psrp-server" do
    command "dpkg -i /var/tmp/psrp-1.0.0-0.universal.x64.deb"
    action :run
  end
  if node[:platform_version].include?("14.04")
    execute "install-powershell-ubuntu-14.04" do
      command "dpkg -i /var/tmp/powershell_6.0.0-alpha.12-1ubuntu1.14.04.1_amd64.deb"
      action :run
    end
  end
  if node[:platform_version].include?("16.04")
    execute "install-powershell-ubuntu-16.04" do
      command "dpkg -i /var/tmp/powershell_6.0.0-alpha.10-1ubuntu1.16.04.1_amd64.deb"
      action :run
    end
  end
  execute "install-powershell-dsc" do
    command "dpkg -i /var/tmp/dsc-1.1.1-294.ssl_100.x64.deb"
    action :run
  end
#sudo powershell "install-module nx -Force"

#https://msdn.microsoft.com/en-us/powershell/dsc/lnxgettingstarted

#https://github.com/PowerShell/PowerShell/releases/tag/v6.0.0-alpha.10
#http://www.howtogeek.com/267858/how-to-install-microsoft-powershell-on-linux-or-os-x/
#http://www.systemcentercentral.com/day-7-install-dsc-providers-linux-ubuntu-12-04/
end
