require 'test_helper'

class ShipmentTest < ActiveSupport::TestCase
  test "open shipments" do
    big = Shipment.create(description: "Big", capacity: 3)
    big.containers.create(description: "Things")
    big.containers.create(description: "Stuff")

    medium = Shipment.create(description: "Medium", capacity: 2)
    medium.containers.create(description: "Whatnot")

    small = Shipment.create(description: "Small", capacity: 1)

    assert_includes Shipment.open, big
    assert_includes Shipment.open, medium
    assert_includes Shipment.open, small

    medium.containers.create(description: "Widgets")

    assert_includes Shipment.open, big
    assert_not_includes Shipment.open, medium
    assert_includes Shipment.open, small
  end
end
