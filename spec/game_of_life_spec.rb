require 'rspec'
require 'open3'
require 'stringio'
require_relative '../game_of_life'

def fake_file_read(filename, contents)
  allow(File).to receive(:open).with(filename).and_return(StringIO.new(contents))
end

describe 'game_of_life' do

  describe 'loading the initial state argument' do

    context 'when the file exists' do
      context 'when the file is in the wrong format' do
        it 'loads the contents of the file' do
          allow(File).to receive(:open).with('wrong_format_file.txt').and_return(StringIO.new("@_x"))
          output = Open3.capture2('./game_of_life', 'wrong_format_file.txt')

        end
      end
    end
  end
end
