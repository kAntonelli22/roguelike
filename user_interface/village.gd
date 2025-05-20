extends Control

@onready var recruit_container: HFlowContainer = $ColorRect/MarginContainer/HBoxContainer/RecruitContainer
var recruit := preload("res://user_interface/recruit.tscn")

func _ready() -> void:
   for i in 4:
      var new_recruit := recruit.instantiate()
      new_recruit.recruit = PlayerStats.new()
      new_recruit.recruit.base_class = Global.classes.keys().pick_random()
      new_recruit.recruit.name = "default"   #TODO replace with random name
      recruit_container.add_child(new_recruit)

func _on_merchant_pressed() -> void:
   pass # Replace with function body.

func _on_tavern_pressed() -> void:
   pass # Replace with function body.

func _on_blacksmith_pressed() -> void:
   pass # Replace with function body.

func _on_start_pressed() -> void:
   get_tree().change_scene_to_packed(Global.map_scene)

func _on_menu_pressed() -> void:
   get_tree().change_scene_to_packed(Global.titlescreen_scene)

func _on_quit_pressed() -> void:
   get_tree().quit()
