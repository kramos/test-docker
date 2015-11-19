require 'spec_helper'


describe "Container" do
  before(:all) do
    @image = Docker::Image.build_from_dir('/docker-file/.')

    set :os, family: :redhat
    set :backend, :docker
    set :docker_image, @image.id
  end

  describe 'get running' do
    before(:all) do
      @container = Docker::Container.create(
        'Image'      => @image.id,
        'HostConfig' => {
          'NetworkMode' => "container:" + ENV['CONTNAME'],
        }
      )

      @container.start
    end

    describe 'check ruby' do
      describe command('ruby --version') do
        its(:stdout) { should match /ruby/ }
        its(:stderr) { should be_empty }
      end
    end

    after(:all) do
      @container.kill
      @container.delete(:force => true)
    end

  end

end
