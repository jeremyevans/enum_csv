require 'rubygems'
require File.join(File.dirname(File.expand_path(__FILE__)), '../lib/enum_csv')
ENV['MT_NO_PLUGINS'] = '1' # Work around stupid autoloading of plugins
require 'minitest/autorun'
require 'minitest/spec'

describe "EnumCSV.csv" do
  TEST_FILE = File.join(File.dirname(File.expand_path(__FILE__)), 'test.csv')
  after do
    File.delete(TEST_FILE) if File.file?(TEST_FILE)
  end

  it "should return string of CSV data for enumerable" do
    EnumCSV.csv([[1, 2]]).must_equal "1,2\n"
    EnumCSV.csv([[1, 2], [3, 4]]).must_equal "1,2\n3,4\n"
    EnumCSV.csv([[1, '2,3'], [3, 4]]).must_equal "1,\"2,3\"\n3,4\n"
    EnumCSV.csv([[1, nil], [3, 4]]).must_equal "1,\n3,4\n"
  end

  it "should support :headers option for a headers string" do
    EnumCSV.csv([[1, 2]], :headers=>['a', 'b']).must_equal "a,b\n1,2\n"
    EnumCSV.csv([[1, 2], [3, 4]], :headers=>['a', 'b']).must_equal "a,b\n1,2\n3,4\n"
    EnumCSV.csv([[1, '2,3'], [3, 4]], :headers=>['a,b', 'c']).must_equal "\"a,b\",c\n1,\"2,3\"\n3,4\n"
    EnumCSV.csv([[1, nil], [3, 4]], :headers=>['a', nil]).must_equal "a,\n1,\n3,4\n"
  end

  it "should support :headers option as a comma delimited string" do
    EnumCSV.csv([[1, 2]], :headers=>'a,b').must_equal "a,b\n1,2\n"
    EnumCSV.csv([[1, 2], [3, 4]], :headers=>'a,b').must_equal "a,b\n1,2\n3,4\n"
  end

  it "should support :file option for writing to a file" do
    EnumCSV.csv([[1, 2]], :file=>TEST_FILE).must_be_nil
    File.read(TEST_FILE).must_equal "1,2\n"
    EnumCSV.csv([[1, 2]], :file=>TEST_FILE, :headers=>['a', 'b'])
    File.read(TEST_FILE).must_equal "a,b\n1,2\n"
  end

  it "should support other csv options" do
    EnumCSV.csv([[1, 2]], :row_sep=>'|').must_equal "1,2|"
    EnumCSV.csv([[1, 2], [3, 4]], :col_sep=>'^').must_equal "1^2\n3^4\n"
  end

  it "should yield elements to the block if given" do
    EnumCSV.csv([[1, 2]]){|l| l.map{|i| i*2}}.must_equal "2,4\n"
    EnumCSV.csv([[1, 2]], :headers=>['a', 'b']){|l| l.map{|i| i*2}}.must_equal "a,b\n2,4\n"
  end

  it "should be callable as a method if including the module" do
    Class.new{include EnumCSV}.new.send(:csv, [[1, 2]]).must_equal "1,2\n"
  end
end
