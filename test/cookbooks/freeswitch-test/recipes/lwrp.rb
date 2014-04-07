freeswitch_user 'joebloggs' do |variable|
  directory 'default'
  password 'foobar'
  vm_password 'barbaz'
  effective_caller_id_name 'Joe Bloggs'
  effective_caller_id_number 'joe@bloggs.com'
end

freeswitch_user 'badguy'

freeswitch_user 'badguy' do
  action :remove
end
