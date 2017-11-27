#
# Cookbook:: role_fs_websvr
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'role_fs_websvr::users' do
  context 'When all attributes are default, on CentOS 7.3.1611' do
    let(:users) do
      [
        {
          id: 'billy',
          password: '$1$qjz$pxRs/vHoupkqRWaELySHR0',
          comment: 'Billy Bob Thornton',
          ssh_keys: [
            'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNvDSdDaFl0PeyoM9vU2d5sC8p7BAt7Z8SF2KpE/+QuKd17tTvAC/9x1pAUj87NSpeEASA7R8n37dKPVlV7tUaiww9BXOwIdyG8G1X0SNQ0A4ehlaUczdSasSKt4e2wMtyzYH2BJ4Y85GAIhVnhQ6kut3q1FoRc00/BoAtmyTr/2XqRmqKOPbyWrkxJVOh+97jAZti1v2WHhmyLwRE1Bwq+754wK7ct5dygV7nZPj4eBJUwjzHdaywzTscVDjyzXyRP8LPBNrh98o9mMWNe83WOR8J5PZ0a6W0lAb8dnbxcdvwTzfjGDc549rhIcI6fslySBa2yYsJkW+b+h7aLHqJ'
          ]
        }
      ]
    end
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611') do |node|
        node.normal['role_fs_websvr']['users'] = users
      end.converge(described_recipe)
    end

    it "should create a user named billy" do
      expect(chef_run).to create_user(users[0]['id']).with(
        password: users[0]['password'],
        comment: users[0]['comment']
      )
    end
  end
end
