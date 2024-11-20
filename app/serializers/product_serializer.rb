class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :stock, :image_url
  has_one :category

  def imgUrl
    object.image_url
  end
end
