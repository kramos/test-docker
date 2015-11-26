require 'spec_helper'


describe "Dockerfile" do
  before(:all) do

  end

  describe 'pass Dockerlint' do
    before(:all) do
      @container = Docker::Container.create(
        'Image'  => 'projectatomic/dockerfile-lint',
        'Cmd'    => ['dockerfile_lint', '-f', '/docker-file/Dockerfile'],
	'AttachStdout' => true,
	'AttachStderr' => true,
        'HostConfig' => {
	  'VolumesFrom': [ENV['CONTNAME']],
        }
      )
  
      set :backend, :exec

    end
    
    it "should be able to create a container" do
      expect(@container).not_to be_nil
    end

    it "should pass lint from within the container" do
      @container.start
      @container.streaming_logs(stdout: true, stderr: true, follow: true) do |stream, message|
        #puts "#{stream}: #{message}"
	expect(message).to match /Check passed/ 
      end

    end

    after(:all) do
      @container.kill
      @container.delete(:force => true)
    end
  end
end
