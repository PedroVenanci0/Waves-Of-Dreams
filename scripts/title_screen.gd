extends Control
@onready var start_impact = $StartImpact

func _on_start_buton_pressed():
	start_impact.play()
	await get_tree().create_timer(2).timeout
	
	# Chamar a transição de cena 
	Global.transitionToScene("tavern")

func _on_quit_buton_pressed():
	get_tree().quit()
