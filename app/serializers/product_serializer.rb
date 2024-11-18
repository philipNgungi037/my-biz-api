class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :stock, :image_url
  belongs_to :category
end
