actions :add, :remove

attribute :id,                          :kind_of => String, :name_attribute => true
attribute :directory,                   :kind_of => String, :default => 'default'
attribute :password,                    :kind_of => String, :default => '$${default_password}'
attribute :vm_password,                 :kind_of => String, :default => '$${default_password}'
attribute :effective_caller_id_name,    :kind_of => String, :default => 'Extension'
attribute :effective_caller_id_number,  :kind_of => String, :default => '$${outbound_caller_id}'
attribute :cookbook,                    :kind_of => String, :default => 'freeswitch'
attribute :template,                    :kind_of => String, :default => 'user.xml.erb'

def initialize(*args)
  super
  @action = :add
end
