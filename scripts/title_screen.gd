extends Control
@onready var start_impact = $StartImpact

func _ready():
	
	var max_enemies = 10
	var enemies_spawn = 0
	var spawn_permission: bool = true

	var enemies_killed: int = 0
	var scene_forest = true  
	var scene_cave = false 

	var damage_player: int = 1
	var life_player: int = 3
	var move_speed: float = 128
	var total_xp: int = 100

	###########################
	var max_chicken = 5
	var max_goblin = 5
	var max_slime = 5
	var max_skeleton = 5
	###########################


func _on_start_buton_pressed():
	if start_impact.playing == false:
		start_impact.play()
		await get_tree().create_timer(2).timeout
	
	# Chamar a transição de cena 
	Global.transitionToScene("tavern")

func _on_quit_buton_pressed():
	get_tree().quit()

func _process(delta):
	var _video = $VideoStreamPlayer as VideoStreamPlayer
	if _video.stream_position >= 3.5:
		_video.paused = true;
