require "chef/resource"

use_inline_resources

action :add do
  reload_resource
  template_resource :create
end

action :remove do
  reload_resource
  template_resource :delete
end

private

def reload_resource
  execute 'freeswitch-reloadxml' do
    command 'fs_cli -x "reloadxml" || true'
    action :nothing
  end
end

def template_resource(exec_action)
  template ::File.join(node['freeswitch']['confpath'], 'directory', new_resource.directory, "#{new_resource.id}.xml") do
    source    new_resource.template
    cookbook  new_resource.cookbook
    user      node['freeswitch']['user']
    group     node['freeswitch']['group']
    variables id: new_resource.id, password: new_resource.password, vm_password: new_resource.vm_password, effective_caller_id_name: new_resource.effective_caller_id_name, effective_caller_id_number: new_resource.effective_caller_id_number
    notifies  :run, 'execute[freeswitch-reloadxml]'
    action    exec_action
  end
end
