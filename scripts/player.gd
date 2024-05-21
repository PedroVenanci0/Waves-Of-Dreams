extends CharacterBody2D

@onready var player = $"."
@onready var _attack_collider = $AttackArea/CollisionShape2D
@onready var enemy:CharacterBody2D = null
@onready var remote = $Remote as RemoteTransform2D
@onready var fx = $FX

var knockbackVelo = Vector2.ZERO
var _state_machine
var _is_attacking = false
var have_potion_cooldown = false

@export_category("Variables")
@export var _attack_timer: Timer = null
@export var _friction: float = 0.2
@export var _acceleration: float = 0.2
@export var _attack_scale = Vector2(1,1)
@export var received_knockback_force : int = 100 

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
	
	if _is_attacking:
		_state_machine.travel("attack")
		return
			
	if velocity.length() > 1:
		_state_machine.travel("walk")
		return
	
	_state_machine.travel("idle")

## Função para ativar a animação da poção usada e atribuir seus efeitos 
func use_potion(effect) -> void:
	
	## Condições baseadas no nome da poção usada, no limite de cada status e se não esta em cooldown de uso
	if effect.name == "Health Potion" and Global.life_player < 5 and have_potion_cooldown == false :
		have_potion_cooldown = true # Ativa o cooldown das poções
		fx.play(effect.name) # Ativa a animação da poção usada
		Global.life_player += 1 # Incrementa os status do player 
		print(Global.life_player)
		await get_tree().create_timer(10).timeout # Inicia o cooldown da poção espefifica 
		have_potion_cooldown = false # Depois do tempod e cooldown volta ao estado inicial 
		
	elif effect.name == "Potion of Speed" and Global.move_speed < 300 and have_potion_cooldown == false :
		have_potion_cooldown = true 
		fx.play(effect.name)
		Global.move_speed += 100
		print(Global.move_speed)
		await get_tree().create_timer(30).timeout
		have_potion_cooldown = false
		Global.move_speed -= 100
		print(Global.move_speed)
		
	elif effect.name == "Potion of Strength" and Global.damage_player < 10 and have_potion_cooldown == false : 
		have_potion_cooldown = true
		fx.play(effect.name)
		Global.damage_player += 1
		print(Global.damage_player)
		await get_tree().create_timer(15).timeout
		have_potion_cooldown = false
		Global.damage_player -= 1
		print(Global.damage_player)

func _on_attack_timer_timeout() -> void:
	_is_attacking = false
	set_physics_process(true)


func _on_attack_area_body_entered(_body) -> void:
	if _body.is_in_group("Enemies"):
		_body.take_damage(Global.damage_player)


func take_damage(damage_enemy,enemyVelocity) -> void:
	print("dmg")
	Global.life_player -= damage_enemy
	if Global.life_player <= 0:
		queue_free()
	else:
		knockback(enemyVelocity)

func knockback (enemyVelocity: Vector2) -> void:
		var knockbackDirection = (enemyVelocity - velocity).normalized() * received_knockback_force
		knockbackVelo = knockbackDirection
		print("knockbackVelo: ", knockbackVelo)
		
func follow_camera(camera) -> void:
	var cam_path = camera.get_path()
	remote.remote_path = cam_path
