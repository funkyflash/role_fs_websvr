#
# Cookbook:: role_fs_websvr
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'role_fs_websvr::users' do
  context 'When all attributes are default, on Centos 7.3.1611' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.3.1611')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should create a user named john' do
      expect(chef_run).to create_user('john')
    end

    it 'should create a user named brian' do
      expect(chef_run).to create_user('brian')
    end
  end
end
