require 'rest-client'

class ReplicaWorker
  include Sidekiq::Worker

  UPLOAD_REQUEST = 1
  DELETE_REQUEST = 2
  UPDATE_REQUEST = 3
# (name, path, type, token, request_type

  def perform(args)
    storage_node_type = NodeType.find_by(name: "storage").id
    storage_nodes = Node.where(node_type_id: storage_node_type)
    storage_nodes.each do |node|
      args[:uri] = URI("http://"+node.address)
      case args[:request_type]
      when UPLOAD_REQUEST
        upload(args)
      when DELETE_REQUEST
        delete(args)
      when UPDATE_REQUEST
        update(args)
      end
    end
  end

  private

  def upload(args, node)
    hash = base_hash(args[:token])
    hash[:dist_file] = {name: args[:name_of_file], attached: File.open(args[:path], "rb")}
    RestClient.post(args[:uri].to_s+"/dist_files/", hash)
  end

  def delete(args, node)
    RestClient.delete(args[:uri].to_s"/dist_file/"+args[:id_of_dist_file])
  end

  def update(args, node)
    puts "lol"
  end

  def base_hash(token)
    {
      token: token
    }
  end
end
