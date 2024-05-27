extends ProgressBar

@onready var healthbar: ProgressBar = $"."

func _process(delta):
	
	# var max_value_fixo = Global.life_cap
	healthbar.max_value = Global.life_cap
	# healthbar.theme_override_styles.fill.bg_color = Color.RED
	# if max_value_fixo <= healthbar.max_value * (50/100):
		#healthbar.theme_override_styles.fill.bg_color = Color.RED
	healthbar.value = Global.life_player
	

