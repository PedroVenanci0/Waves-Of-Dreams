extends Node2D

func _on_timer_timeout():
	Global.transitionToScene(Global.next_scene)

func _process(delta):
	var _pointsNumber = ((Time.get_ticks_msec() / 500) % 3) + 1
	$CanvasLayer/Label.text = "[center][wave]TELEPORTANDO" + str(".").repeat(_pointsNumber)
