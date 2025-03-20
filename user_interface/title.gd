extends Control

#TODO create settings menu
#TODO create guide menu

# ---- # Nodes
@onready var continue_button: Button = $ColorRect/MarginContainer/VBoxContainer/Continue
@onready var start_button: Button = $ColorRect/MarginContainer/VBoxContainer/Start
@onready var settings_button: Button = $ColorRect/MarginContainer/VBoxContainer/Settings
@onready var guide_button: Button = $ColorRect/MarginContainer/VBoxContainer/Guide
@onready var quit_button: Button = $ColorRect/MarginContainer/VBoxContainer/Quit

func _ready() -> void:
   pass # TODO check save manager for a save


func _on_continue_pressed() -> void:
   print_rich("[color=Royalblue]Title[/color]: Continuing Game")

func _on_start_pressed() -> void:
   get_tree().change_scene_to_packed(Global.charcreator_scene)

func _on_settings_pressed() -> void:
   print_rich("[color=Royalblue]Title[/color]: Opening Settings")

func _on_guide_pressed() -> void:
   print_rich("[color=Royalblue]Title[/color]: Opening Guide")

func _on_quit_pressed() -> void:
   get_tree().quit()
