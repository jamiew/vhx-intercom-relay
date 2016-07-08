require 'bundler/setup'
require 'vhx'
require 'dotenv'
Dotenv.load

api_key = ENV['VHX_API_KEY']
raise "You need a VHX_API_KEY environment variable" if api_key.nil? || api_key.empty?
puts "api_key=#{api_key}"

vhx = Vhx.setup(api_key: api_key)

products = Vhx::Product.all
puts "Found #{products.count} products"
products.each do |p|
  puts "#{p.id}: #{p.name} - #{p.href}"
end

product_href = products.last.href
customers = Vhx::Customer.all(product: product_href)
puts "Found #{customers.length} customers for #{product_href}"

customers.each do |c|
  puts "#{c.id}: #{c.email} #{c.name.inspect}"
end

puts "All done"
