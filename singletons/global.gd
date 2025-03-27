extends Node

#FIXME godot is still looking for Singleton instead of singleton
#TODO player party system that holds an array of player stat resources for each member

# ---- # PackedScene
var titlescreen_scene := preload("res://user_interface/title.tscn")
var charcreator_scene := preload("res://user_interface/character_creator.tscn")
var village_scene := preload("res://user_interface/village.tscn")
var battle_scene := load("res://core/battle/battle.tscn")         #HACK cyclical reference when returning to village

# ---- # Resources
var player_stats: PlayerStats = PlayerStats.new()

# ---- # Textures
var godot_icon = preload("res://icon.svg")

# ---- # Classes
var attacks: Dictionary = {
   "stab": Attack.new("Stab", 5, 8, [Effect.Damage.new("Bleed", 2, 1, 3)]),
   "slash": Attack.MultiTarget.new("Slash", 6, 10, [], 2),
   "arrow": Attack.MultiCount.new("Arrow", 3, 5, [Effect.Damage.new("Bleed", 2, 1, 3)], 3),
   "fireball": Attack.new("Fireball", 7, 10, [Effect.Damage.new("Burn", 3, 1, 3)]),
   "lightning": Attack.MultiTarget.new("Lightning", 3, 8, [], 4),
   "heal": Attack.Heal.new("Heal", 5, 8, [Effect.Healing.new("Healing", 2, 0.5)]),
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

# ---- # Palette
# Black - White (#15151A), (#292933), (#3E3E4D), (#A3A3CC), (#B8B8E6), (#CCCCFF),
# Rich Print BBCode (Dimgray), (Springgreen), (Royalblue), (Dimgray), (Dimgray), (#64649E), 
