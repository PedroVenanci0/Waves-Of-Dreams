extends Label
@onready var health = $"."


func _process(delta):
	health.text = str(Global.life_player) + "/" + str(Global.life_cap)
