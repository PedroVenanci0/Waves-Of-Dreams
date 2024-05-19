extends CharacterBody2D

@onready var player = $"."
@onready var _attack_collider = $AttackArea/CollisionShape2D
@onready var enemy:CharacterBody2D = null
@onready var remote = $Remote as RemoteTransform2D

var _state_machine
var _is_attacking = false

@export_category("Variables")
@export var _move_speed: float = 1
@export var _attack_timer: Timer = null
@export var _friction: float = 0.2
@export var _acceleration: float = 0.2
@export var damage_player = 1
@export var life_player = 3
@export var _attack_scale = Vector2(1,1)
@export var knockbackPower : int = 2000

@export_category("Objects")
@export var _animation_tree: AnimationTree = null

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
	var _direction : Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up","move_down")
	)
	
	if _direction != Vector2.ZERO:
		_animation_tree["parameters/idle/blend_position"] =  _direction
		_animation_tree["parameters/walk/blend_position"] =  _direction
		_animation_tree["parameters/attack/blend_position"] =  _direction
		
		
		velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _acceleration)
		velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _acceleration)
		return
		
		
	velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed,_friction)
	velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _friction)
	
	velocity = _direction.normalized() * _move_speed

	
func _attack() -> void:
	_attack_collider.set_deferred("scale",_attack_scale)
	if Input.is_action_just_pressed("attack") and !_is_attacking:
		set_physics_process(false) 
		_attack_timer.start()
		_is_attacking = true
func _animate() -> void:
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


func _on_attack_area_body_entered(_body) -> void:
	if _body.is_in_group("Enemies"):
		_body.take_damage(damage_player)


func take_damage(damage_enemy,enemyVelocity) -> void:
	print("dmg")
	life_player -= damage_enemy
	if life_player <= 0:
		queue_free()
	else:
		knockback(enemyVelocity)

func knockback (enemyVelocity: Vector2):
		var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
		velocity = knockbackDirection
		move_and_slide()
	
func follow_camera(camera):
	var cam_path = camera.get_path()
	remote.remote_path = cam_path
