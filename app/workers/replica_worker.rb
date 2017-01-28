require 'rest-client'
require 'constants'

class ReplicaWorker
  include Sidekiq::Worker
  include Constants

  def perform(name, id, path, token, request_type)
    args = create_args_hash(name, id, path, token, request_type)

    storage_node_type = NodeType.find_by(name: "storage").id
    storage_nodes = Node.where(node_type_id: storage_node_type)
    storage_nodes.each do |node|
      args[:uri] = URI("http://"+node.address)
      Rails.logger.info "lol"
      Rails.logger.info args[:request_type]
      case args[:request_type]
      when UPLOAD_REQUEST
        Rails.logger.info "lol1"
        upload(args)
      when DELETE_REQUEST
        Rails.logger.info "lol2"
        delete(args)
      when UPDATE_REQUEST
        Rails.logger.info "lo3"
        update(args)
      end
    end
  end

  private

  def upload(args)
    Rails.logger.info "lol4"
    hash = base_hash(args[:token])
    hash["format"] = "html"
    hash[:dist_file] = {name: args[:name_of_file], attached: File.open(args[:path], "rb")}
    RestClient.post(args[:uri].to_s+"/dist_files/", hash, {content_type: "html"})
  end

  def delete(args)
    Rails.logger.info "lol5"
    Rails.logger.info args
    RestClient.delete((args[:uri].to_s)+"/dist_file/"+(args[:id_of_dist_file].to_s))
  end

  def update(args)
    puts "lol"
  end

  def base_hash(token)
    {
      token: token
    }
  end

  def create_args_hash(name, id, path, token, request_type)
    {
      id_of_dist_file: id,
      name_of_file: name,
      path: path,
      token: token,
      request_type: request_type
    }
  end
end
