module DistFilesHelper
  def get_file_from_node(dist_file_id)
    storage_node_type = NodeType.find_by(name: "storage").id
    storage_nodes = Node.where(node_type_id: storage_node_type)

    storage_nodes.each do |node|
      node_uri = URI("http://#{node.address}/app/dist_files/#{dist_file_id}.json/?token=#{current_user.get_token}")
      Rails.logger.info(node_uri.to_s)
      response = RestClient.get(node_uri.to_s)
      body = JSON.parse(response.body)
      Rails.logger.info node_uri.to_s+body["attached"]
      return "http://#{node.address}"+body["attached"] if response.code == 200
    end
    return false
  end
end
