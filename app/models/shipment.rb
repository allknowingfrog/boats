class Shipment < ApplicationRecord
  has_many :containers

  def self.open
    where(id: Shipment
      .joins('LEFT JOIN "containers" ON "containers"."shipment_id" = "shipments"."id"')
      .group('"shipments"."id", "shipments"."capacity", "containers"."shipment_id"')
      .having('COUNT("containers"."shipment_id") < "shipments"."capacity"')
    )
  end
end
