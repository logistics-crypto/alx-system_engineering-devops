$file_to_edit = '/var/www/html/wp-settings.php'

# Replace line containing "phpp" with "php"
exec { 'replace_line':
  command => "sed -i 's/phpp/php/g' ${file_to_edit}",
  path    => ['/bin', '/usr/bin'],
  onlyif  => "grep 'phpp' ${file_to_edit}",
  notify  => Service['apache2'],
}

# Ensure Apache service is running and enabled
service { 'apache2':
  ensure    => running,
  enable    => true,
  subscribe => Exec['replace_line'],
}
