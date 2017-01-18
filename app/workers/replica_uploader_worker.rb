require 'rest_client'

class ReplicaUploaderWorker
  include Sidekiq::Worker

  def perform(dist_file)
    storage_node_type = NodeType.find_by(name: "storage").id
    storage_nodes = Node.where(node_type_id: storage_node_type)
    storage_nodes.each do |node|
      RestClient.post(node.address, {
        dist_file: {
          name: dist_file.name,
          attached: File.new(dist_file.attached.path))
        }
      }
    end
  end
end
