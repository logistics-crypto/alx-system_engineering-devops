# Puppet manifest to install and configure Nginx with a 301 redirect

# Install Nginx package
package { 'nginx':
  ensure => 'installed',
}

# Define Nginx configuration file
file { '/etc/nginx/sites-available/default':
  ensure => 'present',
  content => "
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;
    server_name _;

    location / {
        try_files \$uri \$uri/ =404;
    }

    error_page 404 /404.html;
    location  /404.html {
        internal;
    }

    # Redirect /redirect_me to the specified URL with a 301 status
    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }
}
",
  require => Package['nginx'],
}

# Ensure Nginx service is running
service { 'nginx':
  ensure  => 'running',
  require => Package['nginx'],
}