cloudwatch-alarm Cookbook
=========================

The purpose of this cookbook is to create a cloudwatch alert for both cpu usage and
instance status. This cookbook can be applied to an ubuntu or amzn instance.

Requirements
------------

The requirements beyond what come default in the cookbook is nothing out of the ordinary,
you'll need the chef server, workstation and the nodes to deploy to.

Attributes
----------

#### cloudwatch-alarm::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>['alarm']['customer_name']</tt></td>
    <td>String</td>
    <td>This string is going to prefix every single cloudwatch alarm</td>
  </tr>
</table>
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>['alarm']['cpu']['sns']['arn']</tt></td>
    <td>String</td>
    <td>This sns arn is the target for all cpu alarms</td>
  </tr>
</table>
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>['alarm']['status']['sns']['arn']</tt></td>
    <td>String</td>
    <td>This sns arn is the target for all status alarms</td>
  </tr>
</table>

Usage
-----

Just include `cloudwatch-alarm` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[cloudwatch-alarm]"
  ]
}
```

License and Authors
-------------------
Authors: Matt van Zanten
