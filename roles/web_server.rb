name "web_server"
description "A role to configure our front-end web servers"
run_list "recipe[apt]", "recipe[httpd]"
