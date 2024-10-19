class MaintenanceServiceSerializer < ActiveModel::Serializer
  attributes :id, :description, :status, :date, :car_id

  belongs_to :car
end
