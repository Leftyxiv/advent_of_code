#!/usr/bin/env ruby

require 'json'

#
# Usage:
#   ruby enhanced_diff_json.rb file1.json file2.json
#
# This script outputs a more descriptive set of differences between two
# JSON files to "enhanced_diff.json" in the current directory.
#
# Differences are reported with keys like:
#   {
#     "someKey": {
#       "action": "modified",
#       "old": "...",
#       "new": "..."
#     },
#     "anotherKey": {
#       "action": "removed",
#       "old": "...",
#       "new": null
#     }
#   }
#
# If an array is actually an array of objects that each contain a "name" field,
# we convert that array into a hash keyed by "name" before diffing, 
# so that you get descriptive keys in your diff instead of numeric indexes.
#

def enhanced_deep_diff(obj1, obj2)
  # If both objects are exactly the same, no difference
  return nil if obj1 == obj2

  # If both are Hashes, handle them as key-based comparisons
  if obj1.is_a?(Hash) && obj2.is_a?(Hash)
    return diff_hashes(obj1, obj2)
  elsif obj1.is_a?(Array) && obj2.is_a?(Array)
    # Attempt to detect if these are arrays of hashes with a 'name' field
    if array_of_named_objects?(obj1) && array_of_named_objects?(obj2)
      # Convert each array to a hash keyed by .["name"], then diff them as Hashes
      h1 = array_to_hash_by_name(obj1)
      h2 = array_to_hash_by_name(obj2)
      return diff_hashes(h1, h2)
    else
      # Otherwise, compare them by index
      return diff_arrays_by_index(obj1, obj2)
    end
  else
    # Different values or data types – treat it as a "modified" item
    return {
      action: 'modified',
      old: obj1,
      new: obj2
    }
  end
end

def diff_hashes(h1, h2)
  diff_hash = {}
  all_keys = (h1.keys + h2.keys).uniq

  all_keys.each do |key|
    if !h1.key?(key) && h2.key?(key)
      diff_hash[key] = {
        action: 'added',
        old: nil,
        new: h2[key]
      }
    elsif h1.key?(key) && !h2.key?(key)
      diff_hash[key] = {
        action: 'removed',
        old: h1[key],
        new: nil
      }
    else
      sub_diff = enhanced_deep_diff(h1[key], h2[key])
      diff_hash[key] = sub_diff if sub_diff
    end
  end

  diff_hash.empty? ? nil : diff_hash
end

def diff_arrays_by_index(a1, a2)
  diff_array = {}
  max_len = [a1.size, a2.size].max

  (0...max_len).each do |index|
    left_val  = a1[index]
    right_val = a2[index]

    if index >= a1.size
      diff_array[index] = {
        action: 'added',
        old: nil,
        new: right_val
      }
    elsif index >= a2.size
      diff_array[index] = {
        action: 'removed',
        old: left_val,
        new: nil
      }
    else
      sub_diff = enhanced_deep_diff(left_val, right_val)
      diff_array[index] = sub_diff if sub_diff
    end
  end

  diff_array.empty? ? nil : diff_array
end

def array_of_named_objects?(arr)
  # Check that every element is a Hash and has a "name" key
  return false if arr.empty?
  arr.all? { |elem| elem.is_a?(Hash) && elem.key?('name') }
end

def array_to_hash_by_name(arr)
  # Convert array of objects into a Hash keyed by the "name" field
  # If two elements share the same name, last one will overwrite
  arr.each_with_object({}) do |elem, h|
    key_name = elem['name']
    h[key_name] = elem
  end
end

if ARGV.size < 2
  puts "Usage: ruby #{$PROGRAM_NAME} <file1.json> <file2.json>"
  exit 1
end

file1, file2 = ARGV

begin
  json1 = JSON.parse(File.read(file1))
  json2 = JSON.parse(File.read(file2))
rescue Errno::ENOENT => e
  puts "Could not open file: #{e}"
  exit 1
rescue JSON::ParserError => e
  puts "Invalid JSON encountered: #{e}"
  exit 1
end

result_diff = enhanced_deep_diff(json1, json2)

File.open("enhanced_diff.json", "w") do |f|
  f.write(JSON.pretty_generate(result_diff.nil? ? {} : result_diff))
end

puts "diff written to enhanced_diff.json"