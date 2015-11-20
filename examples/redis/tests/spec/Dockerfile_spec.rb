require 'spec_helper'

REDIS_PORT = 6379

describe "Dockerfile" do
  before(:all) do
    @image = Docker::Image.build_from_dir('/docker-file/.')

    set :os, family: :redhat
    set :backend, :docker
    set :docker_image, @image.id
  end

  describe 'Dockerfile#config' do
    it 'should expose the redis port' do
      expect(@image.json['ContainerConfig']['ExposedPorts']).to include("#{REDIS_PORT}/tcp")
    end
  end

  describe file('/etc/centos-release') do
    it { should be_file }
  end

  describe package('redis') do
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

    describe 'round trip a key' do

      describe command('redis-cli set test_key "hi markos"') do
        its(:stdout) { should match /OK/ }
      end

      describe command('redis-cli get test_key') do
        its(:stdout) { should match /hi markos/ }
      end

    end

    describe command('redis-cli info') do
      its(:stdout) { should match /redis_version:/ }
    end

    after(:all) do
      @container.kill
      @container.delete(:force => true)
#      #@image.remove(:force => true)
    end
  end
end
