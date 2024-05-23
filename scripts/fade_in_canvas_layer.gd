extends CanvasLayer

## PackedScene distino da transição
@export var destiny_scene: PackedScene = null
var nextSceneString: String = "";
var progress: float = 0.0
@onready var colorRect: ColorRect = get_node("ColorRect")

func _process(delta):
	progress = move_toward(progress, 1.0, 0.025)
	colorRect.color.a = progress
	if progress >= 1.0:
		get_tree().change_scene_to_packed(destiny_scene)
		Global.actualSceneKey = nextSceneString;
		queue_free()
