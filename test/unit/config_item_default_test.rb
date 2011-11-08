#
# Copyright 2011 National Institute of Informatics.
#
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
require 'test_helper'

class ConfigItemDefaultTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  # called before every single test
  def setup
    @cid = ConfigItemDefault.new(:software => Software.find_by_name("nova"), :name => 'test', :value => 'localhost')
  end

  # called after every single test
  def teardown
    @cid = nil
  end

  test "should not save ConfigItemDefault without software" do
    @cid.software = nil
    assert !@cid.save
  end

  test "should not save ConfigItemDefault without name" do
    @cid.name = nil
    assert !@cid.save
  end

  test "should not save ConfigItemDefault without value" do
    @cid.value = nil
    assert !@cid.value
  end

  test "should not save ConfigItemDefault duplicated unique keys" do
    @cid.save
    lcid = ConfigItemDefault.new(:software => Software.find_by_name("nova"), :name => 'test', :value => 'localhost')
    assert !lcid.save
  end

  test "should be success saved ConfigItemDefault duplicated software_id" do
    @cid.value = nil
    lcid = ConfigItemDefault.new(:software => Software.find_by_name("nova"), :name => 'test2', :value => 'localhost')
    assert lcid.save
  end

  test "should be success saved ConfigItemDefault duplicated name" do
    @cid.value = nil
    lcid = ConfigItemDefault.new(:software => Software.find_by_name("glance"), :name => 'test', :value => 'localhost')
    assert lcid.save
  end

  test "should be success saved ConfigItemDefault" do
    assert @cid.save
  end

end
