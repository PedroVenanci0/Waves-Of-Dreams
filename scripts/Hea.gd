extends Label
@onready var health = $"."


func _process(delta):
	health.text = "VIDA: " +  str(Global.life_player)
