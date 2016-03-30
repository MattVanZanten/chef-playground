#
# Cookbook Name:: cloudwatch-alarm
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
if node[:platform_family].include?("debian")
  include_recipe "apt"
elsif node[:platform_family].include?("rhel")
  include_recipe "yum"
end

if node[:platform_family].include?("debian")
  package 'awscli' do
    action :install
  end
end

metadata_uri = "http://169.254.169.254/latest/meta-data/"
az = `curl #{metadata_uri}placement/availability-zone`
region = `echo #{az} | sed "s/[a-z]$//"`
instance_id = `curl #{metadata_uri}instance-id`
cpu_alarm_name = "#{node['alarm']['customer_name']}-#{node['alarm']['namespace']['ec2']}-#{instance_id}-#{node['alarm']['cpu']['cloudwatch']['metric']}"
status_alarm_name = "#{node['alarm']['customer_name']}-#{node['alarm']['namespace']['ec2']}-#{instance_id}-#{node['alarm']['status']['cloudwatch']['metric']}"

execute "create cpu alarm" do
  command "aws cloudwatch put-metric-alarm --alarm-name #{cpu_alarm_name} --alarm-description #{node['alarm']['cpu']['cloudwatch']['description']} --actions-enabled --alarm-actions --metric-name #{node['alarm']['cpu']['cloudwatch']['metric']} --namespace #{node['alarm']['namespace']['ec2']} --statistic Average --period #{node['alarm']['cpu']['cloudwatch']['period']} --threshold #{node['alarm']['cpu']['cloudwatch']['threshold']} --comparison-operator #{node['alarm']['cpu']['cloudwatch']['comparison-operator']} --dimensions \"Name=InstanceId,Value=#{instance_id}\" --evaluation-periods #{node['alarm']['cpu']['cloudwatch']['evaluation-periods']}  --unit Percent --alarm-actions #{node['alarm']['sns']['arn']} --region #{region}"
end

execute "create cpu alarm" do
  command "aws cloudwatch put-metric-alarm --alarm-name #{status_alarm_name} --alarm-description #{node['alarm']['status']['cloudwatch']['description']} --actions-enabled --alarm-actions --metric-name #{node['alarm']['status']['cloudwatch']['metric']} --namespace #{node['alarm']['namespace']['ec2']} --statistic Average --period #{node['alarm']['status']['cloudwatch']['period']} --threshold #{node['alarm']['status']['cloudwatch']['threshold']} --comparison-operator #{node['alarm']['status']['cloudwatch']['comparison-operator']} --dimensions \"Name=InstanceId,Value=#{instance_id}\" --evaluation-periods #{node['alarm']['status']['cloudwatch']['evaluation-periods']}  --unit Percent --alarm-actions #{node['alarm']['sns']['arn']} --region #{region}"
end
