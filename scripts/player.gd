extends CharacterBody2D

@onready var player = $"."
#@onready var ray_right = $ray_right
#@onready var ray_left = $ray_left
@onready var _attack_collider = $AttackArea/CollisionShape2D
@export var _attack_scale = Vector2(1,1)


var _state_machine
var _is_attacking = false

@export_category("Variables")
@export var _move_speed: float = 1
@export var _attack_timer: Timer = null
@export var _friction: float = 0.2
@export var _acceleration: float = 0.2
@export var damage_player = 1
@export var life_player = 3
#var knockback_vector : Vector2 = Vector2.ZERO

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


func take_damage(damage_enemy) -> void:
	print("dmg")
	life_player -= damage_enemy
	if life_player <= 0:
		queue_free()
	
#func knockback (knockback_force := Vector2.ZERO, duration := 0.25):
		#if knockback_force != Vector2.ZERO:
			#knockback_vector = knockback_force
			#var knocknack_tween := get_tree().create_tween()
			#knocknack_tween.tween_property(self, "knockback_vector", Vector2.ZERO, duration)
			#animation.modulate = Color(1,0,0,1)
			#knocknack_tween.tween_property(animation, "modulate", Color(1,1,1,1), duration)


#func _on_hurtbox_body_entered(body):
	#if body.is_in_group("enemies"):
		#queue_free()
	#if life_player == 0:
		#puff = true
		#$CollisionShape2D.queue_free()
		#await get_tree().create_timer(0.5).timeout
		#queue_free()
	#else:
	
	##KBdir é a direção do knockback, onde ira subtrair o ray cast do que foi detectado pelo outro que foi ou não
	#var kbDir = sign(int(ray_left.is_colliding()) - int(ray_right.is_colliding()))
	
	#if kbDir != 0:
		##Colocar valor padrão para manuseio
		#var kbAmount = 200;
		##Verificar se o valor sera positivo, negativo ou zero
		#var kbValue = kbAmount * kbDir;
		##Chama a função take_damage colocando os vetores nescessarios para a função
		#dknockback(Vector2(kbValue, -kbAmount))
