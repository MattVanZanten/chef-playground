httpd Cookbook
==============
The purpose for this little guy is to run an apache server, easy eh.

Requirements
------------
Requirements? what requirements, its an apache server plain and simple. Probably
got this cookbook from a tutorial, just saiyan.

Attributes
----------
Nope none of these in here.

Usage
-----
Just include `httpd` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[httpd]"
  ]
}
```

Authors: Matt van Zanten
