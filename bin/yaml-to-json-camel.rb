#!/usr/bin/env ruby
require "yaml"
require "json"
require "active_support/inflector"

def transform_keys(object)
  case object
  when Hash
    object.transform_keys! { |key| key.to_s.camelize(:lower) }
    object.each_value { |value| transform_keys(value) }
  when Array
    object.each { |value| transform_keys(value) }
  end
end

# If there's a file name as the first argument, read from the file.
# Otherwise, read from standard input.
yaml_content = ARGV[0] ? File.read(ARGV[0]) : $stdin.read

parsed_yaml = YAML.safe_load(yaml_content, aliases: true)
transform_keys(parsed_yaml)
puts JSON.pretty_generate(parsed_yaml)
