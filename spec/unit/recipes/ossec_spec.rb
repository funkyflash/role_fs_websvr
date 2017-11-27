#
# Cookbook:: role_fs_websvr
# Spec:: ossec
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
    # let(:dest_addr) { 'infrastructure@firstscribe.com'}
    # let(:source_addr) { 'the_os_of_cent@firstscribe.com' }

    it 'creates the atomic repo' do
      expect(chef_run).to add_yum_repository('atomic').with(enabled: false)
    end

    it 'installs ossec server' do
      expect(chef_run).to install_yum_package('ossec-hids-server')
    end

    it 'configures ossec server' do
      expect(chef_run).to create_template('/var/ossec/etc/ossec.conf')
      expect(chef_run).to restart_service('ossec_server')
    end

    it 'should ensure ossec_server is started and enabled' do
      expect(chef_run).to start_service('ossec_server')
      expect(chef_run).to enable_service('ossec_server')
    end
  end
end
