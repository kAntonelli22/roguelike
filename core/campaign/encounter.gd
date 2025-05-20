class_name MapEncounter
extends Node2D


@export var scene: PackedScene

func load_encounter():
   get_tree().change_scene_to_packed(scene)
