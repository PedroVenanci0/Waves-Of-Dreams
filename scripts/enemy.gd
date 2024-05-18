extends CharacterBody2D

@export var speed = 32
@export var enemy_life = 3
@export var damage_enemy = 1

var direction := Vector2.ZERO
var player_chese = false
var player = null

func _physics_process(_delta):
	if player_chese:
		velocity = position.direction_to(player.position - Vector2(0,-20)) * speed
		move_and_slide()

func _on_detection_body_entered(body):
	player = body
	player_chese = true

func _on_detection_body_exited(_body):
	player = null
	player_chese = false

func take_damage(damage_player) -> void:
	enemy_life -= damage_player
	if enemy_life <= 0:
		queue_free()

func _on_damage_enemy_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(damage_enemy)
		
	
