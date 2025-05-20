class_name Party
extends Resource

@export_category("members")
@export var max_size: int = 4
@export var size: int
@export var members: Array[PlayerStats]

@export_category("campaign")
@export var campaign_position: int
@export var campaign_progress: float
@export var progress: int
@export var icon: Texture

@export_category("resources")
@export var gold: int
@export var inventory: Array

func add_member(member: PlayerStats):
   if size+1 > max_size: printerr("party max size reached")
   else: members.append(member)

func remove_member(member: PlayerStats):
   var member_index: int = members.find(member)
   if member_index != -1: members.remove_at(member_index)
   else: printerr("member ", member, " is not a party member")

func add_item(item: Item):
   inventory.append(item)

func remove_item(item: Item):
   var item_index: int = inventory.find(item)
   if item_index != -1: inventory.remove_at(item_index)
   else: printerr("item ", item, " is not in party inventory")

func modify_resource(resource: String, quantity: int, set_value: bool):
   if set_value == true:   # add/subtract
      set(resource, get(resource) + quantity)
   else:                   # set
      set(resource, quantity)
