yum Cookbook
============
Pretty much just runs yum update -y, lets make sure we run this before we do anything
important, cant be running behind on security updates, am I right?

Requirements
------------
Requirements? to update your rh linux machine? :^)


Attributes
----------
None of these in here, its some pretty basic stuff.

Usage
-----
Just include `yum` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[yum]"
  ]
}
```


License and Authors
-------------------
Authors: Matt van Zanten
