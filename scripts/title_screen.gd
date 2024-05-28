extends Control
@onready var start_impact = $StartImpact

func _ready():
	
	Global.max_enemies = 5
	Global.enemies_spawn = 0
	Global.spawn_permission = true
	Global.damage_enemy = 1
	Global.enemies_killed = 0
	Global.scene_forest = true  
	Global.scene_cave = false 
	Global.num_wave = 1
	Global.life_cap = 5
	Global.enemy_life = 1

	Global.damage_player = 1
	Global.life_player =  5
	Global.move_speed = 130
	Global.total_xp = 0

	Global.onTavern = true 


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
