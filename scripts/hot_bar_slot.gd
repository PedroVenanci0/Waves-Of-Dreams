extends Button

## Variavel para encontrar o player entre as cenas
@onready var player = get_tree().current_scene.find_child("player")


@export var stats: Item = null:
	set(value):
		stats = value
		
		if value != null:
			icon = value.icon
		else:
			icon = null

func _ready():
	set_process_input(false)

## Função para usar o item com base no input do player 
func _input(event):
	if event.is_action_pressed('use'):
		use_item()
		
## Função para usar o item selecionado
func use_item():
	if stats == null:
		return
	player.use_potion(stats)
