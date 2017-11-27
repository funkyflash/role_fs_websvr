name 'role_fs_websvr'
maintainer 'Alex Funk'
maintainer_email 'lexotron314@gmail.com'
license 'GPL-3.0'
description 'Prepares a web server at First Scribe'
long_description 'Performs all of the first steps common on First Scribe web servers.'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)
issues_url 'https://github.com/funkyflash/role_fs_websvr/issues' if respond_to?(:issues_url)
source_url 'https://github.com/funkyflash/role_fs_websvr' if respond_to?(:source_url)
supports 'centos', '~> 7.0'

depends 'line'
depends 'users'
