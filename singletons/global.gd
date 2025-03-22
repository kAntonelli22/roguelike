extends Node

#FIXME godot is still looking for Singleton instead of singleton
#TODO player party system that holds an array of player stat resources for each member

# ---- # PackedScene
var titlescreen_scene := preload("res://user_interface/title.tscn")
var charcreator_scene := preload("res://user_interface/character_creator.tscn")
var battle_scene := preload("res://core/battle/battle.tscn")

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
      "attacks": knight_attacks
      },
   "Archer": {
      "sprite": preload("res://core/entities/entity_assets/SpriteFrames/samuraiFrames.tres"),
      "attacks": archer_attacks
      },
   "Mage": {
      "sprite": preload("res://core/entities/entity_assets/SpriteFrames/mageFrames.tres"),
      "attacks": mage_attacks
      },
}

# ---- # Palette
# (#15151A), (#292933), (#3E3E4D), (#A3A3CC), (#B8B8E6), (#CCCCFF), 
