class_name Item
extends Control

#TODO find a way to load image and data of the item held by the class
@onready var select_button: Button = $SelectButton
@onready var background: TextureRect = $Background
@onready var item_number: Label = $Background/ItemNumber
@onready var item_texture: TextureRect = $Background/ItemTexture
@onready var overlay: TextureRect = $Background/Overlay
@onready var overlay_text: Label = $Background/Overlay/OverlayText


var item_name: String = "item"

func _ready() -> void:
   overlay_text.text = item_name

func _on_mouse_entered() -> void:
   overlay.show()

func _on_mouse_exited() -> void:
   overlay.hide()

func _on_select_button_pressed() -> void:
   get_tree().paused = false
