extends Control


@onready var sprite: AnimatedSprite2D = $Background/Sprite
@onready var stats: Label = $Background/Stats
@onready var recruit_name: Label = $Background/Overlay/Name
@onready var button: Button = $Button

@export var recruit: PlayerStats

func ready():
   recruit_name.text = recruit.name
   stats.text = "health: " + str(recruit.health) + "\nspeed: " + str(recruit.speed)
   sprite.sprite_frames = Global.classes[recruit].sprite

func _on_button_pressed() -> void:
   button.disabled = true
   var player: PlayerStats = PlayerStats.new()
   Global.party.add_member(recruit)
