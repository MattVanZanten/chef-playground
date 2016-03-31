#
# Cookbook Name:: cloudwatch-alarm
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# determine if instance is debian or rh
if node[:platform_family].include?("debian")
  include_recipe "apt"
elsif node[:platform_family].include?("rhel")
  include_recipe "yum"
end

# install awscli if instance is debian
if node[:platform_family].include?("debian")
  package 'awscli' do
    action :install
  end
end

# collect region and instance id, set alarm name
metadata_uri = "http://169.254.169.254/latest/meta-data/"
az = `curl #{metadata_uri}placement/availability-zone`
region = `echo #{az} | sed "s/[a-z]$//"`
instance_id = `curl #{metadata_uri}instance-id`

# collect environment info from tags
tags = `aws ec2 describe-tags --region us-west-2 --filters "Name=resource-id,Values=#{instance_id}" --output text`
if tags.downcase.include? "prod"
  environment = "Prod"
elsif tags.downcase.include? "stag"
  environment = "Staging"
elsif tags.downcase.include? "test"
  environment = "Test"
elsif tags.downcase.include? "dr"
  environment = "DR"
end

# set the name of the alarm
cpu_alarm_name = "#{node['alarm']['customer_name']}-#{node['alarm']['namespace']['ec2']}-#{environment}-#{instance_id}-#{node['alarm']['cpu']['cloudwatch']['metric']}"
status_alarm_name = "#{node['alarm']['customer_name']}-#{node['alarm']['namespace']['ec2']}-#{environment}-#{instance_id}-#{node['alarm']['status']['cloudwatch']['metric']}"

execute "create cpu alarm" do
  command "aws cloudwatch put-metric-alarm --alarm-name #{cpu_alarm_name} --alarm-description '#{node['alarm']['cpu']['cloudwatch']['description']}'' --actions-enabled --alarm-actions --metric-name #{node['alarm']['cpu']['cloudwatch']['metric']} --namespace #{node['alarm']['namespace']['ec2']} --statistic Average --period #{node['alarm']['cpu']['cloudwatch']['period']} --threshold #{node['alarm']['cpu']['cloudwatch']['threshold']} --comparison-operator #{node['alarm']['cpu']['cloudwatch']['comparison-operator']} --dimensions \"Name=InstanceId,Value=#{instance_id}\" --evaluation-periods #{node['alarm']['cpu']['cloudwatch']['evaluation-periods']}  --unit Percent --alarm-actions #{node['alarm']['sns']['arn']} --region #{region}"
end

execute "create status alarm" do
  command "aws cloudwatch put-metric-alarm --alarm-name #{status_alarm_name} --alarm-description '#{node['alarm']['status']['cloudwatch']['description']}' --actions-enabled --alarm-actions --metric-name #{node['alarm']['status']['cloudwatch']['metric']} --namespace #{node['alarm']['namespace']['ec2']} --statistic Average --period #{node['alarm']['status']['cloudwatch']['period']} --threshold #{node['alarm']['status']['cloudwatch']['threshold']} --comparison-operator #{node['alarm']['status']['cloudwatch']['comparison-operator']} --dimensions \"Name=InstanceId,Value=#{instance_id}\" --evaluation-periods #{node['alarm']['status']['cloudwatch']['evaluation-periods']}  --unit Percent --alarm-actions #{node['alarm']['sns']['arn']} --region #{region}"
end
