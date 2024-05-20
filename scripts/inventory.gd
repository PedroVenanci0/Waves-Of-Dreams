extends PanelContainer

@onready var texture_rect = $TextureRect

func _get_drag_data(at_position):
	set_drag_preview(get_preview())
	
	return texture_rect
	
func _can_drop_data(at_position, data):
	return data is TextureRect #Verifica se a data consegue ser dropada

#Função para trocar a textura
func _drop_data(at_position, data):
	var temp = texture_rect.texture
	texture_rect.texture = data.texture
	data.texture = temp

#Função de preview ao segurar o item e soltar no slot
func get_preview():
	var preview_texture = TextureRect.new()
	
	preview_texture.texture = texture_rect.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30,30)
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	
	return preview
