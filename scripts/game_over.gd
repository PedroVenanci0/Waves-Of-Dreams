extends Control

func _on_resert_bt_pressed():
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")


func _on_quit_btn_pressed():
	get_tree().quit()
