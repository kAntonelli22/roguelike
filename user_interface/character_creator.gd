extends Control


# ---- # Nodes
@onready var left_arrow: Button = $ColorRect/MarginContainer/VBoxContainer/ClassSelection/LeftArrow
@onready var right_arrow: Button = $ColorRect/MarginContainer/VBoxContainer/ClassSelection/RightArrow

@onready var scroll_container: ScrollContainer = $ColorRect/MarginContainer/VBoxContainer/ClassSelection/ScrollContainer
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

# ---- # Class Selection Right Arrow
func _on_right_arrow_pressed() -> void:
   scroll_container.scroll_horizontal += min_size
   selected_class = class_labels[scroll_container.scroll_horizontal / min_size].text
   
# ---- # Start Game
func _on_start_pressed() -> void:
   var player: PlayerStats = PlayerStats.new()
   player.base_class = selected_class
   player.name = char_name
   Global.party.add_member(player)
   Global.party.icon = Global.classes[selected_class].icon
   get_tree().change_scene_to_packed(Global.village_scene)

# ---- # Return To Menu
func _on_exit_pressed() -> void:
   get_tree().change_scene_to_packed(Global.titlescreen_scene)

# ---- # Update Character Name
func _on_line_edit_text_changed(new_text: String) -> void:
   char_name = new_text
