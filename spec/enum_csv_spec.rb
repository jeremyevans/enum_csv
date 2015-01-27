require 'rubygems'
require File.join(File.dirname(File.expand_path(__FILE__)), '../lib/enum_csv')

describe "EnumCSV.csv" do
  TEST_FILE = File.join(File.dirname(File.expand_path(__FILE__)), 'test.csv')
  after(:all) do
    File.delete(TEST_FILE)
  end

  it "should return string of CSV data for enumerable" do
    EnumCSV.csv([[1, 2]]).should == "1,2\n"
    EnumCSV.csv([[1, 2], [3, 4]]).should == "1,2\n3,4\n"
    EnumCSV.csv([[1, '2,3'], [3, 4]]).should == "1,\"2,3\"\n3,4\n"
    EnumCSV.csv([[1, nil], [3, 4]]).should == "1,\n3,4\n"
  end

  it "should support :headers option for a headers string" do
    EnumCSV.csv([[1, 2]], :headers=>['a', 'b']).should == "a,b\n1,2\n"
    EnumCSV.csv([[1, 2], [3, 4]], :headers=>['a', 'b']).should == "a,b\n1,2\n3,4\n"
    EnumCSV.csv([[1, '2,3'], [3, 4]], :headers=>['a,b', 'c']).should == "\"a,b\",c\n1,\"2,3\"\n3,4\n"
    EnumCSV.csv([[1, nil], [3, 4]], :headers=>['a', nil]).should == "a,\n1,\n3,4\n"
  end

  it "should support :headers option as a comma delimited string" do
    EnumCSV.csv([[1, 2]], :headers=>'a,b').should == "a,b\n1,2\n"
    EnumCSV.csv([[1, 2], [3, 4]], :headers=>'a,b').should == "a,b\n1,2\n3,4\n"
  end

  it "should support :file option for writing to a file" do
    EnumCSV.csv([[1, 2]], :file=>TEST_FILE).should be_nil
    File.read(TEST_FILE).should == "1,2\n"
    EnumCSV.csv([[1, 2]], :file=>TEST_FILE, :headers=>['a', 'b'])
    File.read(TEST_FILE).should == "a,b\n1,2\n"
  end

  it "should support other csv options" do
    EnumCSV.csv([[1, 2]], :row_sep=>'|').should == "1,2|"
    EnumCSV.csv([[1, 2], [3, 4]], :col_sep=>'^').should == "1^2\n3^4\n"
  end

  it "should yield elements to the block if given" do
    EnumCSV.csv([[1, 2]]){|l| l.map{|i| i*2}}.should == "2,4\n"
    EnumCSV.csv([[1, 2]], :headers=>['a', 'b']){|l| l.map{|i| i*2}}.should == "a,b\n2,4\n"
  end

  it "should be callable as a method if including the module" do
    Class.new{include EnumCSV}.new.send(:csv, [[1, 2]]).should == "1,2\n"
  end
end
