extends CharacterBody2D

@export_category("Variables")
@export var knockback_cooldown = 0.5
@onready var animation = $AnimatedSprite2D



var enemy_life = Global.enemy_life
var direction := Vector2.ZERO
var player_chese = false
var player = null
var facing: int = 1;

func _ready(): 
	enemy_life = Global.enemy_life

func _physics_process(_delta):
	if player_chese:
		velocity = global_position.direction_to(player.global_position) * Global.enemy_speed
	
	if velocity.x != 0:
		facing = sign(velocity.x)
		
	$AnimatedSprite2D.scale.x = facing
	move_and_slide()

func _on_detection_body_entered(body):
	if body is Player:
		player = body
		player_chese = true

func _on_detection_body_exited(body):
	if body is Player:
		player = null
		player_chese = false

func take_damage(damage_player) -> void:
	enemy_life -= damage_player
	animation.modulate = Color(1,0,0,1)
	set_physics_process(false)
	animation.pause()
	await get_tree().create_timer(0.2).timeout
	animation.play()
	set_physics_process(true)
	animation.modulate = Color(1,1,1,1)
	if enemy_life <= 0:
		Global.enemies_killed += 1
		print("Kills: ",Global.enemies_killed)
		queue_free()

func _on_damage_enemy_body_entered(body):
	if body is Player:
		body.take_damage(Global.damage_enemy, velocity)
		print("Enemy dmg: ", Global.damage_enemy)

