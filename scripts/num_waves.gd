extends Label
@onready var waves = $"."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	waves.text = "Wave: " + str(Global.num_wave) 
