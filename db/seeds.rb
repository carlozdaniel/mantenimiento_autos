# Crear 50 autos de prueba
cars = []
50.times do |i|
  cars << Car.create(
    plate_number: "PLATE#{i+1}",
    model: [ "Toyota Corolla", "Honda Civic", "Ford Focus", "Mazda 3", "Chevrolet Spark" ].sample,
    year: rand(2000..2023)
  )
end

# Crear 50 servicios de mantenimiento para los autos creados
50.times do
  MaintenanceService.create(
    car: cars.sample,
    description: [ "Cambio de aceite", "Cambio de filtros", "Alineación y balanceo", "Revisión de frenos", "Revisión de motor", "Cambio de bujías", "Cambio de batería", "Mantenimiento general" ].sample,
    status: [ :pending, :in_progress, :completed ].sample,
    date: rand(Date.new(2022, 1, 1)..Date.today)
  )
end
