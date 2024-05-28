extends CharacterBody2D
class_name Player

@onready var player = $"."
@onready var _attack_collider = $AttackArea/CollisionShape2D
@onready var enemy:CharacterBody2D = null
@onready var remote = $Remote as RemoteTransform2D
@onready var fx = $FX
@export var inventory: Inventory
@onready var audio_attack = $AudioStreamPlayer2D

var knockbackVelo = Vector2.ZERO
var _state_machine
var _is_attacking = false
var _is_dying = false
var have_potion_cooldown = false

@export_category("Variables")
@export var _attack_timer: Timer = null
@export var _friction: float = 0.2
@export var _acceleration: float = 0.2
@export var _attack_scale = Vector2(1,1)
@export var received_knockback_force : int = 500

@export_category("Objects")
@export var _animation_tree: AnimationTree = null

var myPortal: Portal = null;

func _ready() -> void:
	player.add_to_group("player")
	_animation_tree.active = true
	_state_machine = _animation_tree["parameters/playback"]
	
@export_category("variables")

func _physics_process(_delta: float) -> void:
	_move()
	_attack()
	_animate()
	move_and_slide()
	
	
func _move() -> void:
	if myPortal != null:
		velocity = Vector2.ZERO;
		global_position = global_position.lerp(myPortal.global_position, 0.169)
		return
	
	var _direction : Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up","move_down")
	)
		
	
	if _direction != Vector2.ZERO  and knockbackVelo.length() <= 0:

		_animation_tree["parameters/idle/blend_position"] =  _direction
		_animation_tree["parameters/walk/blend_position"] =  _direction
		_animation_tree["parameters/attack/blend_position"] =  _direction
		
		velocity.x = lerp(velocity.x, _direction.normalized().x * Global.move_speed, _acceleration)
		velocity.y = lerp(velocity.y, _direction.normalized().y *Global.move_speed, _acceleration)
		return
		
	
	velocity.x = lerp(velocity.x, _direction.normalized().x * Global.move_speed,_friction)
	velocity.y = lerp(velocity.y, _direction.normalized().y * Global.move_speed, _friction)
	
	velocity = _direction.normalized() * Global.move_speed + knockbackVelo
	var _sp = knockbackVelo.length()/5
	knockbackVelo = knockbackVelo.move_toward(Vector2.ZERO,_sp) 

	
func _attack() -> void:
	_attack_collider.set_deferred("scale",_attack_scale)
	if Input.is_action_just_pressed("attack") and !_is_attacking:
		set_physics_process(false) 
		_attack_timer.start()
		_is_attacking = true
		
func _animate() -> void:
	if _is_dying:
		_state_machine.travel("dying")
	
	if _is_attacking:
		_state_machine.travel("attack")
		return
			
	if velocity.length() > 1:
		_state_machine.travel("walk")
		return
	
	_state_machine.travel("idle")

func _on_attack_timer_timeout() -> void:
	_is_attacking = false
	set_physics_process(true)
"floor_stop_on_slope"

func _on_attack_area_body_entered(_body) -> void:
	audio_attack.playing = true
	if _body.is_in_group("Enemies"):
		_body.take_damage(Global.damage_player)


func take_damage(damage_enemy,enemyVelocity) -> void:
	Global.life_player -= damage_enemy
	player.modulate = Color(1,0,0,1)
	if Global.life_player <= 0:
		#await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	else:
		knockback(enemyVelocity)
		await get_tree().create_timer(0.3).timeout
		player.modulate = Color(1,1,1,1)

func knockback (enemyVelocity: Vector2) -> void:
		var knockbackDirection = (enemyVelocity - velocity).normalized() * received_knockback_force
		knockbackVelo = knockbackDirection
		print("knockbackVelo: ", knockbackVelo)
		
func follow_camera(camera) -> void:
	print("Executando follow_camera do player")
	var cam_path = camera.get_path()
	remote.remote_path = cam_path
