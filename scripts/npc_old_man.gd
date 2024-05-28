extends CharacterBody2D
class_name NPC

const _DIALOG_SCREEN: PackedScene = preload("res://scenes/dialog_screen.tscn")

var _dailog_data: Dictionary = {
	0: {
		"faceset": "res://assets/NPC pack/Old man/Old man portrait.png",
		"dialog": "O que o trouxe a esse lugar tão perigoso, viajante?",
		"title": "Old Man",
	}, 
	
	1: {
		"faceset": "res://assets/NPC pack/Default_parecida_com_essa_so_que_em_outro_ambiante_e_em_outra_3.png",
		"dialog":  "Um sonho estranho, amigo. Vi inúmeros inimigos entrelaçados em 20 níveis. Dizem que quem suportar até o fim ganhará a vida eterna, e eu será aquele que irá encontra-la.",
		"title": "Aventureiro",
	}, 
	
	2: {
		"faceset": "res://assets/NPC pack/Old man/Old man portrait.png",
		"dialog": "hummm... Bastante interessante, Vou lhe ajudar!! Entre no corredor a minha direita, vc achará oq procura.",
		"title": "Old Man",
	},
}

@export_category("Objects")
@export var _hud: CanvasLayer = null

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("dialog_btn"):
		var _new_dialog: DialogScreen = _DIALOG_SCREEN.instantiate()
		_new_dialog.data = _dailog_data
		_hud.add_child(_new_dialog)
