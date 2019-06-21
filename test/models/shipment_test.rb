require 'test_helper'

class ShipmentTest < ActiveSupport::TestCase
  test "not empty" do
    big = Shipment.create(description: "Big", capacity: 3)
    big.containers.create(description: "Things")
    big.containers.create(description: "Stuff")

    small = Shipment.create(description: "Small", capacity: 1)

    assert_includes Shipment.not_empty, big
    assert_not_includes Shipment.not_empty, small

    small.containers.create(description: "Widgets")

    assert_includes Shipment.not_empty, big
    assert_includes Shipment.not_empty, small
  end

  test "empty" do
    big = Shipment.create(description: "Big", capacity: 3)
    big.containers.create(description: "Things")
    big.containers.create(description: "Stuff")

    small = Shipment.create(description: "Small", capacity: 1)

    assert_not_includes Shipment.empty, big
    assert_includes Shipment.empty, small

    small.containers.create(description: "Widgets")

    assert_not_includes Shipment.empty, big
    assert_not_includes Shipment.empty, small
  end

  test "not full" do
    big = Shipment.create(description: "Big", capacity: 3)
    big.containers.create(description: "Things")
    big.containers.create(description: "Stuff")

    small = Shipment.create(description: "Small", capacity: 1)

    assert_includes Shipment.not_full, big
    assert_includes Shipment.not_full, small
    assert_equal 2, Shipment.not_full.count

    small.containers.create(description: "Widgets")

    assert_includes Shipment.not_full, big
    assert_not_includes Shipment.not_full, small
  end
end
