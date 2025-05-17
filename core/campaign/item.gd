class_name Item
extends Control

#TODO find a way to load image and data of the item held by the class
@onready var select_button: Button = $SelectButton
@onready var background: TextureRect = $Background
@onready var item_number: Label = $Background/ItemNumber
@onready var item_texture: TextureRect = $Background/ItemTexture
@onready var overlay: TextureRect = $Background/Overlay
@onready var overlay_text: Label = $Background/Overlay/OverlayText


@export var item_name: String = "item"
@export var resource: String = "resource"
@export var quantity: int = 0
@export var set_quantity: bool = false
@export var inventory_item: bool = false

func _ready() -> void:
   overlay_text.text = item_name
   if quantity != 1: item_number.text = str(quantity)
   else: item_number.hide()

func _on_mouse_entered() -> void:
   overlay.show()

func _on_mouse_exited() -> void:
   overlay.hide()

func _on_select_button_pressed() -> void:
   if inventory_item: Global.party.add_item(self)
   else: Global.party.modify_resource(resource, quantity, set_quantity)
   get_tree().paused = false
