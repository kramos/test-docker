require 'spec_helper'

describe "Dockerfile" do
  before(:all) do
    @image = Docker::Image.build_from_dir('/docker-file/.')

    set :os, family: :ubuntu
    set :backend, :docker
    set :docker_image, @image.id
  end

  describe file('/usr/local/bin/drush') do
    it { should be_file }
  end

  describe package('openssh-server') do
    it { should be_installed }
  end



  describe 'Dockerfile#running' do
    before(:all) do
      @container = Docker::Container.create(
        'Image'      => @image.id,
	'HostConfig' => {
          'NetworkMode' => "container:" + ENV['CONTNAME'],
        }
      )

      @container.start
      sleep 5
    end

    describe command('/usr/local/bin/drush version') do
      its(:stdout) { should match /Drush Version/ }
    end

    after(:all) do
      @container.kill
      @container.delete(:force => true)
    end
  end
end
