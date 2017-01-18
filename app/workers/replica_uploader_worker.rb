require 'rest-client'

class ReplicaUploaderWorker
  include Sidekiq::Worker

  def perform(name, path, type, token)
    storage_node_type = NodeType.find_by(name: "storage").id
    storage_nodes = Node.where(node_type_id: storage_node_type)
    storage_nodes.each do |node|

      RestClient.post("http://"+node.address+"/dist_files/", {
        token: token,
        dist_file: {
          name: name,
          attached: File.open("/Users/jameseggers/Projects/backProj.png", 'rb')
        }
      }, {format: "HTML"})
    end
  end
end
