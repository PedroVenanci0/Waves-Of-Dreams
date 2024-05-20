extends Resource
class_name Item

@export var icon: Texture2D
@export var name: String

@export_enum("Weapon","Consumable")
var type = "Weapon"

@export_multiline var descripition: String
