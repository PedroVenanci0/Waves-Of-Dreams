extends Area2D
class_name portal


@onready var portal_collider = $CollisionShape2D

@export_category("Variables") 
@export var destiny: String

@export_category("objects")
@export var _animator: AnimatedSprite2D = null

#func _process(delta):
	#if Global.enemies_killed == Global.max_enemies:
		#portal_collider.set_deferred("disabled",false)
		#_animator.play("spawn")
		#await  _animator.animation_finished
		#_animator.play("idle")
		#Global.enemies_killed = 0

## Função que verifica se o player entrou no portal
func _on_body_entered(_body) -> void:
	if _body is CharacterBody2D:
		Global.scene_forest = false
		Global.scene_cave = true       # pergunta para nicolas
		## Teleporta para a cena destino
		Global.total_xp += 1
		Global.transitionToScene(destiny)

	## Fazer o portal desaparecer
		#_animator.play("disappearing")
		#portal_collider.set_deferred("disabled", true)

			
#func _on_animator_animation_finished():
	#_animator.play("spawn")
	#await get_tree().create_timer(0.8).timeout
	#_animator.play("idle")
	#portal_collider.set_deferred("disabled", false)
