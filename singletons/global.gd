extends Node

# ---- # PackedScene
var titlescreen_scene := preload("res://user_interface/title.tscn")
var charcreator_scene := preload("res://user_interface/character_creator.tscn")
var battle_scene := preload("res://core/battle/battle.tscn")

# ---- # Resources
var player_stats: PlayerStats = PlayerStats.new()

# ---- # Palette
# (#15151A), (#292933), (#3E3E4D), (#A3A3CC), (#B8B8E6), (#CCCCFF), 
