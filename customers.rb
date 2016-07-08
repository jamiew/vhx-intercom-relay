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

# FIXME @sgrshah customers() call is returning lots of duplicate records
# getting 500+ entries when I expect ~5

real_customers = []
customers.each do |c|
  # puts "#{c.id}: #{c.email} #{c.name.inspect}"
  real_customers << c.email unless real_customers.include?(c.email)
end

puts "#{real_customers.length} real customers"
puts real_customers.inspect



