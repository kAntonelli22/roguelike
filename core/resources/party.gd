class_name Party
extends Resource

@export var max_size: int
@export var size: int
@export var members: Array[PlayerStats]

@export var campaign_position: int

func add_member(member: PlayerStats):
   members.append(member)
