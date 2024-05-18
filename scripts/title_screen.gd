extends Control
@onready var start_impact = $StartImpact


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_buton_pressed():
	start_impact.play()
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_quit_buton_pressed():
	get_tree().quit()
