name "development"
description "The master development branch"
cookbook_versions({
    "httpd" => "<= 0.1.0",
    "apt" => "= 0.1.0"
})
override_attributes ({
    "httpd" => {
        "listen" => [ "80", "443" ]
    },
    "mysql" => {
        "root_pass" => "root"
    }
})
