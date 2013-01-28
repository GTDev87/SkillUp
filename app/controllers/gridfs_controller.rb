class GridfsController < ApplicationController

  def serve
    gridfs_path = env["PATH_INFO"].gsub("/upload/grid/", "")
    begin
      gridfs_file = Mongoid::GridFS[gridfs_path]
      self.response_body = gridfs_file.data
      self.content_type = gridfs_file.content_type
    rescue
      self.status = :file_not_found
      self.content_type = 'text/plain'
      self.response_body = ''
    end
  end

private
  ### OH MY GAWD THIS NEEDS A TESTING... SUPER HACK
  def current_resource
    user_id = params[:path].gsub("user/avatar/", "").gsub(/\/.*/, "")
    @current_resource ||= User.find(user_id) if user_id
  end
end
