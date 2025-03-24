extends Control




func _on_merchant_pressed() -> void:
   pass # Replace with function body.

func _on_tavern_pressed() -> void:
   pass # Replace with function body.

func _on_blacksmith_pressed() -> void:
   pass # Replace with function body.

func _on_start_pressed() -> void:
   get_tree().change_scene_to_packed(Global.battle_scene)

func _on_menu_pressed() -> void:
   get_tree().change_scene_to_packed(Global.titlescreen_scene)

func _on_quit_pressed() -> void:
   get_tree().quit()
