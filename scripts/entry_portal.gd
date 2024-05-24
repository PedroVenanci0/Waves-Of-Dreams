extends Area2D
@onready var _animator = $Animator
@onready var portal_collider = $CollisionShape2D
@onready var cpu_particles_2d = $CPUParticles2D

func _ready():
	
	_animator.play("disappearing")
	portal_collider.set_deferred("disabled", true)
	cpu_particles_2d.emitting = false
