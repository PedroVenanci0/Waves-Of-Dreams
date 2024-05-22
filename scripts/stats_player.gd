extends Control

@onready var total_xp = $stats/volue/TotalXP
@onready var hp = $stats/volue/HP
@onready var move_speed = $stats/volue/MoveSpeed
@onready var strenght = $stats/volue/Strenght


func _process(delta):
	
	total_xp.text = str(Global.total_xp)
	hp.text = str(Global.life_player)
	move_speed.text = str(Global.move_speed)
	strenght.text = str(Global.damage_player)
	
	if Input.is_action_just_pressed("toggle_inventory"):
		visible = !visible
	
func _on_hp_button_pressed():
	if Global.total_xp > 0:
		Global.life_player += 10
		Global.total_xp -= 1
	
func _on_speed_button_pressed():
	if Global.total_xp > 0:
		Global.move_speed += 10
		Global.total_xp -= 1
	
func _on_strenght_button_pressed():
	if Global.total_xp > 0:
		Global.damage_player += 10
		Global.total_xp -= 1
		
