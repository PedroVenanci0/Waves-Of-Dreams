extends HBoxContainer

@onready var slots = get_children()

var current_index: int:
	set(value):
		current_index = value
		reset_focus()
		set_focus()
		
func _ready():
	current_index = 0
	
## Função que desativa o input de use
func reset_focus():
	for slot in slots:
		slot.set_process_input(false)
		
func set_focus():
	get_child(current_index).grab_focus()
	get_child(current_index).set_process_input(true)
	
	
func _input(event):
	if event.is_action_pressed("scroll_down"):
		if current_index == get_child_count() - 1:
			current_index = 0
		else:
			current_index += 1
			
	if event.is_action_pressed("scroll_up"):
		if current_index == 0:
			current_index = get_child_count() - 1
		else:
			current_index -= 1
