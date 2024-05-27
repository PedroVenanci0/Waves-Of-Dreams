extends Control

@onready var total_xp = $stats/volue/TotalXP
@onready var hp = $stats/volue/HP
@onready var move_speed = $stats/volue/MoveSpeed
@onready var strenght = $stats/volue/Strenght
var points_hp = 0
var points_speed = 0
var points_stg = 0

func _process(delta):
	
	total_xp.text = str(Global.total_xp)
	hp.text = str(points_hp)
	move_speed.text = str( points_speed )
	strenght.text = str(points_stg )
	
	if Input.is_action_just_pressed("toggle_inventory"):
		visible = !visible
		
	
func _on_hp_button_pressed():
	if Global.total_xp > 0:
		points_hp += 1
		Global.life_cap += 1
		Global.total_xp -= 1
		
	
func _on_speed_button_pressed():
	if Global.total_xp > 0:
		points_speed += 1
		Global.move_speed += Global.move_speed * 5/100
		Global.total_xp -= 1
	
func _on_strenght_button_pressed():
	if Global.total_xp > 0:
		points_stg += 1
		Global.damage_player += 1
		Global.total_xp -= 1
		
