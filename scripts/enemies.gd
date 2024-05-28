extends Label

@onready var enemies = $"."

func _process(delta):
	enemies.text = "Enemies: " + str(Global.enemies_killed) + "/" + str(Global.max_enemies * 2)
