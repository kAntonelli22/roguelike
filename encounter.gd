class_name MapEncounter
extends Area2D

#TODO add disabled bool that greys out and disables encounter 

@export var scene: PackedScene

func load_encounter():
   get_tree().change_scene_to_packed(scene)

func _on_body_entered(body: Node2D) -> void:
   body.position = position      # save position
   call_deferred("load_encounter")


func _on_body_exited(body: Node2D) -> void:
   pass
