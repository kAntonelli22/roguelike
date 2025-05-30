extends Node

#FIXME godot is still looking for Singleton instead of singleton
#TODO create code to read in info from a database and create excel sheets for classes, weapons, items, and encounters

# ---- # PackedScene
var titlescreen_scene := preload("res://user_interface/title.tscn")
var charcreator_scene := preload("res://user_interface/character_creator.tscn")
var village_scene := preload("res://user_interface/village.tscn")
var map_scene := load("res://core/campaign/campaign.tscn")
var battle_scene := load("res://core/battle/battle.tscn")         #HACK cyclical reference when returning to village

# ---- # Player and Enemy Scenes
var player := preload("res://core/entities/player.tscn")
var enemy := preload("res://core/entities/enemy.tscn")

# ---- # Resources
var party: Party = Party.new()

# ---- # Textures
var godot_icon = preload("res://icon.svg")

# ---- # Classes
var attacks: Dictionary = {
   "stab": Attack.new("Stab", 1, 1, 5, 8, [Effect.Damage.new("Bleed", 2, 1, 3)]),
   "slash": Attack.new("Slash", 1, 2, 6, 10, []),
   "arrow": Attack.MultiCount.new("Arrow", 2, 1, 3, 5, [Effect.Damage.new("Bleed", 2, 1, 3)], 3),
   "fireball": Attack.new("Fireball", 1, 1, 7, 10, [Effect.Damage.new("Burn", 3, 1, 3)]),
   "lightning": Attack.new("Lightning", 2, 4, 3, 8, []),
   "heal": Attack.Heal.new("Heal", 1, 1, 5, 8, [Effect.Healing.new("Healing", 2, 0.5)]),
}
var classes: Dictionary = {
   "Knight": {
      "sprite": preload("res://core/entities/entity_assets/SpriteFrames/knightFrames.tres"),
      "icon": preload("res://core/entities/entity_assets/knight/Knight_1/Icon.png"),
      "attacks": [attacks.stab, attacks.slash]
      },
   "Archer": {
      "sprite": preload("res://core/entities/entity_assets/SpriteFrames/samuraiFrames.tres"),
      "icon": preload("res://core/entities/entity_assets/Samurai/Samurai_Archer/icon.png"),
      "attacks": [attacks.stab, attacks.arrow]
      },
   "Mage": {
      "sprite": preload("res://core/entities/entity_assets/SpriteFrames/mageFrames.tres"),
      "icon": preload("res://core/entities/entity_assets/wizard/Lightning Mage/Icon.png"),
      "attacks": [attacks.fireball, attacks.lightning, attacks.heal]
      },
}


# ---- # Credit stuff
# - gold assets - https://opengameart.org/content/gold-treasure-icons
