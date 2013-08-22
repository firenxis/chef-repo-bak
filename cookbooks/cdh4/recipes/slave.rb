#
# Cookbook Name:: cdh4
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'cdh4'

package 'hadoop-client'

services = ['hadoop-0.20-mapreduce-tasktracker', 'hadoop-hdfs-datanode']

services.each do |daemon|
  package daemon do
    options "--force-yes"
  end
end

include_recipe 'cdh4::cluster'

template '/etc/hadoop/conf.cluster/core-site.xml' do
  source 'slave/core-site.xml.erb'
  mode 0644
end

template '/etc/hadoop/conf.cluster/hdfs-site.xml' do
  source 'slave/hdfs-site.xml.erb'
  mode 0644
end

template '/etc/hadoop/conf.cluster/mapred-site.xml' do
  source 'slave/mapred-site.xml.erb'
  mode 0644
end

directory '/var/lib/hadoop-data/dfs/dn' do
  owner 'hdfs'
  group 'hdfs'
  mode 0700
  recursive true
end

template '/etc/hadoop/conf.cluster/log4j.properties' do
  source 'log4j.properties'
  mode 0644
end

template '/etc/hadoop/conf.cluster/hadoop-metrics2.properties' do
  source 'hadoop-metrics.properties'
  mode 0644
end

directory '/var/lib/hadoop-data/mapred/local' do
  owner 'mapred'
  group 'hadoop'
  mode 0755
  recursive true
end

services.each do |daemon|
  service daemon do
    action [:enable, :start]
  end
end
