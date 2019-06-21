class Shipment < ApplicationRecord
  has_many :containers

  def self.not_empty
    joins(:containers)
  end

  def self.empty
    left_joins(:containers).where(containers: { id: nil })
  end

  def self.not_full
    where(id: Shipment
      .joins('LEFT JOIN "containers" ON "containers"."shipment_id" = "shipments"."id"')
      .group('"shipments"."id", "shipments"."capacity", "containers"."shipment_id"')
      .having('COUNT("containers"."shipment_id") < "shipments"."capacity"')
    )
  end
end
