default['alarm']['customer_name'] = ''
default['alarm']['namespace']['ec2'] = 'AWS/EC2'
default['alarm']['sns']['arn'] = ''
default['alarm']['cpu']['cloudwatch']['metric'] = 'CPUUtilization'
default['alarm']['cpu']['cloudwatch']['evaluation-periods'] = '1'
default['alarm']['cpu']['cloudwatch']['period'] = '3600'
default['alarm']['cpu']['cloudwatch']['threshold'] = '90'
default['alarm']['cpu']['cloudwatch']['comparison-operator'] = 'GreaterThanOrEqualToThreshold'
default['alarm']['cpu']['cloudwatch']['description'] = 'Notify when cpu utilization is too high.'
default['alarm']['status']['sns']['arn'] = ''
default['alarm']['status']['cloudwatch']['metric'] = 'StatusCheckFailed'
default['alarm']['status']['cloudwatch']['evaluation-periods'] = '1'
default['alarm']['status']['cloudwatch']['period'] = '60'
default['alarm']['status']['cloudwatch']['threshold'] = '1'
default['alarm']['status']['cloudwatch']['comparison-operator'] = 'GreaterThanOrEqualToThreshold'
default['alarm']['status']['cloudwatch']['description'] = 'Notify when instance status check fails.'
