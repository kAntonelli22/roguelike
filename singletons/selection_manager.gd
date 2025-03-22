extends Node

# ---- # Variables
var attack_selection
var multi_selection

var entities_selected: Array[Entity] = []
var targets_selected: Array[Entity] = []

func _ready() -> void:
   SignalBus.connect("selected", select_entity)


func select_entity(entity: Entity):
   var array: Array[Entity] = entities_selected if !attack_selection else targets_selected
   if multi_selection:
      array.append(entity)
      entity.select()
   else:
      for element in array:
         element.deselect()
      array.append(entity)
      entity.select()

func deselect_all():
   for entity in entities_selected:
         entity.deselect()
   entities_selected.clear()

func get_targets() -> Array[Entity]:
   var array = targets_selected
   targets_selected.clear()
   return array

func toggle_attack_selection():
   attack_selection = !attack_selection

func toggle_multi_selection():
   multi_selection = !multi_selection
