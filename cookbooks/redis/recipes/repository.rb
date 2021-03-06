package 'python-software-properties'
package 'software-properties-common'

apt_repository 'redis-server' do
  uri 'http://ppa.launchpad.net/chris-lea/redis-server/ubuntu'
  distribution node['lsb']['codename']
  components ['main']
  keyserver "keyserver.ubuntu.com"
  key "C7917B12"
  action :add
end

package 'redis-server'

service 'redis-server' do
  supports :status => true, :restart => true
  action [:enable, :start]
end
