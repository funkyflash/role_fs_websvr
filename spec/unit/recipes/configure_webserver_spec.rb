#
# Cookbook:: role_fs_websvr
# Spec:: configure_webserver
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'role_fs_websvr::users' do
  context 'When all attributes are default, on CentOS 7.3.1611' do
    let(:site_address) { 'meow.puma.com'}
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611') do |node|
        node.normal['role_fs_websvr']['sites'] = [site_address]
      end.converge(described_recipe)
    end

    it 'creates the site directories' do
      expect(chef_run).to create_directory("/var/www/vhosts/#{site_address}").with(user: site_address, group: nginx)
      expect(chef_run).to create_directory("/var/www/vhosts/#{site_address}/httpdocs").with(user: site_address, group: nginx)
      expect(chef_run).to create_directory("/var/www/vhosts/#{site_address}/certs").with(user: site_address, group: nginx)
      expect(chef_run).to create_directory("/var/www/vhosts/#{site_address}/logs").with(user: site_address, group: nginx)
    end

    # This is an example of how separate configuration could be included
    # it 'configured to levels of the shit' do
    #   expect(chef_run).to include_recipe('jason_bomb_configuration::nginx')
    # end

    it 'should include apc in php modules' do
      # I don't know how to test external cookbooks:
      #  https://github.com/chefspec/chefspec#testing-lwrps
      expect(chef_run).to restart_service('php-fpm')
    end

    %w(nginx postfix php-fpm).each do |svc|
      it "starts and enables the #{svc} service" do
        expect(chef_run).to start_service(svc)
        expect(chef_run).to enable_service(svc)
      end
    end

    it 'creates git exclusion config' do
      expect(chef_run).to create_file('/etc/httpd/conf.d/blockgit.conf')
    end
  end
end
