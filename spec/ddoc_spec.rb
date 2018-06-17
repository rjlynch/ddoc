require 'spec_helper'
require 'byebug'
require 'fixtures/default_test'

describe Ddoc do
  let :fixtures do
    File.dirname(__FILE__) + '/fixtures'
  end

  let :expected do
    File.read(fixtures + "/#{test_name}_expected.ddoc.rb")
  end

  let :result do
    File.read(fixtures + "/#{test_name}_result.ddoc.rb")
  end

  context 'Default options' do
    let(:test_name) { 'default' }

    before do
      TestClass.class_method
      TestClass.new('foo').instance_method_with_args(7)
    end

    it "doesn't break return values" do
      expect(TestClass.new('foo').instance_method_with_args(7)).to eq [7]
    end

    it 'generates correct documentation' do
      expect(result).to eq expected
    end
  end
end
