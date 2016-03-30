apt Cookbook
============

The purpose for this cookbook is to run apt get update before doing anything else.

Requirements
------------

There really are no requirement, just make sure you are using debian.

Attributes
----------

Nothing to do here, its so very simple.

Usage
-----

Just include `apt` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[apt]"
  ]
}
```
Authors:
Matt van Zanten
