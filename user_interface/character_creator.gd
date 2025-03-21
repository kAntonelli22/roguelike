extends Control

#TODO add Village scene where player can visit blacksmith, merchant, etc.
#TODO campaign map scene where player moves along a linear path to the next fight and village/town
#HACK clean up the @onready nodes

# ---- # Nodes
@onready var menu_container: VBoxContainer = $ColorRect/MarginContainer/VBoxContainer
@onready var class_selection: HBoxContainer = menu_container.get_node("ClassSelection")
@onready var left_arrow: Button = class_selection.get_node("LeftArrow")
@onready var right_arrow: Button = class_selection.get_node("RightArrow")

@onready var scroll_container: ScrollContainer = class_selection.get_node("ScrollContainer")
@onready var knight_label: Label = scroll_container.get_node("HBoxContainer/Knight")
@onready var archer_label: Label = scroll_container.get_node("HBoxContainer/Archer")
@onready var mage_label: Label = scroll_container.get_node("HBoxContainer/Mage")
@onready var class_labels = [knight_label, archer_label, mage_label]
@onready var label_sizes = [
   knight_label.get_combined_minimum_size().x, 
   archer_label.get_combined_minimum_size().x, 
   mage_label.get_combined_minimum_size().x
]
@onready var min_size = label_sizes.max()

# ---- # Variables
var selected_class: String = "Knight"
var char_name: String

# ---- # Ready
func _ready() -> void:
   knight_label.set_custom_minimum_size(Vector2(min_size, 0))
   archer_label.set_custom_minimum_size(Vector2(min_size, 0))
   mage_label.set_custom_minimum_size(Vector2(min_size, 0))

# ---- # Class Selection Right Arrow 
func _on_left_arrow_pressed() -> void:
   scroll_container.scroll_horizontal -= min_size
   selected_class = class_labels[scroll_container.scroll_horizontal / min_size].text
   print(selected_class)

# ---- # Class Selection Right Arrow
func _on_right_arrow_pressed() -> void:
   scroll_container.scroll_horizontal += min_size
   selected_class = class_labels[scroll_container.scroll_horizontal / min_size].text
   print(selected_class)
   
# ---- # Start Battle
func _on_start_pressed() -> void:
   Global.player_stats.base_class = selected_class
   Global.player_stats.name = char_name
   get_tree().change_scene_to_packed(Global.battle_scene)

# ---- # Return To Menu
func _on_exit_pressed() -> void:
   get_tree().change_scene_to_packed(Global.titlescreen_scene)

# ---- # Update Character Name
func _on_line_edit_text_changed(new_text: String) -> void:
   char_name = new_text
