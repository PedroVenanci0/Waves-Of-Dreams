extends ProgressBar

@onready var healthbar: ProgressBar = $"."

func _process(delta):
	healthbar.max_value = Global.life_cap
	healthbar.value = Global.life_player
	

