require 'spec_helper'

describe "Image" do

  before(:all) do
    @image = Docker::Image.build_from_dir('/docker-file/.')

    set :os, family: :redhat
    set :backend, :docker
    set :docker_image, @image.id
  end

  describe 'inpsect metadata' do
    it 'should not expose any ports' do
      expect(@image.json['ContainerConfig']['ExposedPorts']).to be_nil
    end
  end

  after(:all) do
#      #@image.remove(:force => true)
  end

end

