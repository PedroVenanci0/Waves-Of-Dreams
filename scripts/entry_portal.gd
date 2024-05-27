extends Area2D
@onready var _animator = $Animator
@onready var portal_collider = $CollisionShape2D
@onready var cpu_particles_2d = $CPUParticles2D
@onready var entry_portal = $"."

func _ready():
	
	_animator.play("disappearing")
	await _animator.animation_finished
	entry_portal.queue_free()
