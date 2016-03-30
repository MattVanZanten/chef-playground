file '/tmp/messages/motd' do
  action :delete
end

directory '/tmp/messages' do
  action :delete
end
