class ScrapingSourceSerializer < ActiveModel::Serializer
  attributes :uuid, :url, :status
end
