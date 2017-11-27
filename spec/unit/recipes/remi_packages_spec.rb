#
# Cookbook:: role_fs_websvr
# Spec:: remi_packages
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'role_fs_websvr::users' do
  context 'When all attributes are default, on CentOS 7.3.1611' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611')
      runner.converge(described_recipe)
    end

    let(:remi_packages) {%w(php-fpm php-devel php-pear php-mysql php-gd php-soap
      php-xml php-mcrypt redis php-pecl-redis php-mbstring php-imagick nginx
      php-pear php-devel httpd-devel)}

    it 'installs the remi repository' do
      expect(chef_run).to install_yum_package('remi-release')
    end

    it 'should install all the things' do
      expect(chef_run).to install_yum_package(remi_packages)
    end
  end
end
