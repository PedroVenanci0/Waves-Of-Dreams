extends CharacterBody2D

@export_category("Variables")
@export var speed = 32
@export var enemy_life = 3
@export var damage_enemy = 1
@export var knockback_cooldown = 0.5
@export var max_goblin = 5
@export var max_chicken = 5

var direction := Vector2.ZERO
var player_chese = false
var player = null

func _physics_process(_delta):
	print("player_chase:", player_chese)
	if player_chese:
		velocity = global_position.direction_to(player.global_position - Vector2(0,-20)) * speed
		move_and_slide()
		print("enemy: ",position)

func _on_detection_body_entered(body):
	player = body
	player_chese = true

func _on_detection_body_exited(_body):
	player = null
	player_chese = false

func take_damage(damage_player) -> void:
	enemy_life -= damage_player
	if enemy_life <= 0:
		Global.enemies_killed += 1
		queue_free()

func _on_damage_enemy_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(damage_enemy, velocity)
		set_physics_process(false)
		await get_tree().create_timer(knockback_cooldown).timeout
		set_physics_process(true)
		
