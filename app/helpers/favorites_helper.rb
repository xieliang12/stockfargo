module FavoritesHelper
  def tag_links(tags)
    tags.map { |t| link_to t, tag_path(t.strip) }
  end
end
