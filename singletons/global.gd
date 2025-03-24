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
var knight_attacks: Array[Attack] = [Attack.new(), Attack.MultiCountAttack.new()]
var archer_attacks: Array[Attack] = [Attack.new()]
var mage_attacks: Array[Attack] = [Attack.new(), Attack.MultiTargetAttack.new()]
var classes: Dictionary = {
   "Knight": {
      "sprite": preload("res://core/entities/entity_assets/SpriteFrames/knightFrames.tres"),
      "icon": preload("res://core/entities/entity_assets/knight/Knight_1/Icon.png"),
      "attacks": knight_attacks
      },
   "Archer": {
      "sprite": preload("res://core/entities/entity_assets/SpriteFrames/samuraiFrames.tres"),
      "icon": preload("res://core/entities/entity_assets/Samurai/Samurai_Archer/icon.png"),
      "attacks": archer_attacks
      },
   "Mage": {
      "sprite": preload("res://core/entities/entity_assets/SpriteFrames/mageFrames.tres"),
      "icon": preload("res://core/entities/entity_assets/wizard/Lightning Mage/Icon.png"),
      "attacks": mage_attacks
      },
}

#TODO attack dictionaries that hold each possible attack

# ---- # Palette
# Black - White (#15151A), (#292933), (#3E3E4D), (#A3A3CC), (#B8B8E6), (#CCCCFF),
# Rich Print BBCode (Dimgray), (Springgreen), (Royalblue), (Dimgray), (Dimgray), (#64649E), 
