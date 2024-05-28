extends Control

@onready var fx_2 = $"../../player/FX2"
@onready var total_xp = $stats/volue/TotalXP
@onready var hp = $stats/volue/HP
@onready var move_speed = $stats/volue/MoveSpeed
@onready var strenght = $stats/volue/Strenght
var points_hp = 5
var points_speed = 5
var points_stg = 5

func _process(delta):
	
	total_xp.text = str(Global.total_xp)
	hp.text = str(points_hp)
	move_speed.text = str( points_speed )
	strenght.text = str(points_stg )
	if Global.onTavern:
		Global.life_player = Global.life_cap
	
	if Input.is_action_just_pressed("toggle_inventory"):
		visible = !visible
		
	
func _on_hp_button_pressed():
	if Global.total_xp > 0:
		points_hp += 1
		Global.life_cap += 1
		Global.total_xp -= 1
		fx_2.play("Health Potion")
	
func _on_speed_button_pressed():
	if Global.total_xp > 0:
		points_speed += 1
		Global.move_speed += Global.move_speed * 7/100
		Global.total_xp -= 1
		fx_2.play("Potion of Speed")
	
func _on_strenght_button_pressed():
	if Global.total_xp > 0:
		points_stg += 1
		Global.damage_player += 1
		Global.total_xp -= 1
		fx_2.play("Potion of Strength")
