big = Shipment.create(description: "Big", capacity: 3)
big.containers.create(description: "Things")
big.containers.create(description: "Stuff")

small = Shipment.create(description: "Small", capacity: 1)
