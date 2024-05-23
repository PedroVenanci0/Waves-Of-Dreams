extends Area2D
class_name portal


@onready var portal_collider = $CollisionShape2D

@export_category("Variables") 
@export var destiny: String

@export_category("objects")
@export var _animator: AnimatedSprite2D = null

func _process(delta):
	if Global.enemies_killed >= Global.max_enemies:
		portal_collider.set_deferred("disabled",false)
		_animator.play("spawn")
		await  _animator.animation_finished
		_animator.play("idle")
		Global.enemies_killed = 0

## Retorna a chave da scene correspondente ao numero da wave no momento
func getDestinyByWaveNumber() -> String:
	if Global.num_wave < 10:
		return "forest";
	if Global.num_wave < 20:
		return "cave";
	# TODO: Valor padrão. Foi uma solução para evitar crash.
	return "tavern"
	

## Função que verifica se o player entrou no portal
func _on_body_entered(_body) -> void:
	if _body is CharacterBody2D:
		# Se entrou a partir do bar:
		if Global.onTavern:
			destiny = getDestinyByWaveNumber();
			Global.onTavern = false;
		else: # Caso contrário (player na fase):
			# Saber se o numero da wave corresponde a um checkpoint para o bar
			if Global.num_wave % 5 == 0:
				destiny = "tavern"
			else:
				destiny = getDestinyByWaveNumber();
		
		# Experiência do jogador
		Global.total_xp += 1
		
		# Transiciona finalmente para a cena destino.
		Global.transitionToScene(destiny)

	## Fazer o portal desaparecer
		#_animator.play("disappearing")
		#portal_collider.set_deferred("disabled", true)

			
#func _on_animator_animation_finished():
	#_animator.play("spawn")
	#await get_tree().create_timer(0.8).timeout
	#_animator.play("idle")
	#portal_collider.set_deferred("disabled", false)
