class_name MapEncounter
extends Node2D

#TODO add disabled bool that greys out and disables encounter 

@export var scene: PackedScene

func load_encounter():
   get_tree().change_scene_to_packed(scene)

func _on_body_exited(body: Node2D) -> void:
   pass
