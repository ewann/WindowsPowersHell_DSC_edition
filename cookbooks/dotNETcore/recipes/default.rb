#
# Cookbook Name:: dotNETcore
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

case node[:platform]
when "ubuntu"
    case node[:platform_version]
    #common prereqs
    when "14.04","16.04"
        apt_repository "dotnet-release" do
            uri "https://apt-mo.trafficmanager.net/repos/dotnet-release"
            distribution node['lsb']['codename']
            components ["main"]
            keyserver "keyserver.ubuntu.com"
            key "417A0893"
            notifies :run, 'execute[apt-get-update]', :immediately
        end
        execute "apt-get-update" do
            command "apt-get update"
            ignore_failure true
            action :nothing
        end
        package "dotNETcore" do
            package_name 'dotnet-dev-1.0.0-preview2-003131'
        end
    end
end

