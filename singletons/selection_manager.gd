extends Node

# ---- # Variables
var attack_selection
var multi_selection

var entities_selected: Array[Entity] = []
var targets_selected: Array[Entity] = []

func _ready() -> void:
   SignalBus.connect("selected", select_entity)
   SignalBus.connect("end_turn", next_turn)


func select_entity(entity: Entity):
   if entities_selected.has(entity): entities_selected.remove_at(entities_selected.find(entity))
   if targets_selected.has(entity): targets_selected.remove_at(targets_selected.find(entity))
   
   var array: Array[Entity]
   if !attack_selection:
      array = entities_selected
      print_rich("[color=Springgreen]Selection Manager[/color]: using entity array")
   else:
      array = targets_selected
      print_rich("[color=Springgreen]Selection Manager[/color]: using target array")
      
   if multi_selection:
      print_rich("[color=Springgreen]Selection Manager[/color]: ", entity.name, " selected")
      array.append(entity)
      entity.select()
   else:
      print_rich("[color=Springgreen]Selection Manager[/color]: ", entity.name, " selected")
      deselect_all(array)
      array.append(entity)
      entity.select()

func deselect_all(array):
   print_rich("[color=Springgreen]Selection Manager[/color]: clearing array")
   for element in array:
         element.deselect()
   array.clear()

func get_targets() -> Array[Entity]:
   print_rich("[color=Springgreen]Selection Manager[/color]: providing target array duplicate")
   var array = targets_selected.duplicate()
   deselect_all(targets_selected)
   return array

func next_turn():
   deselect_all(entities_selected)
   deselect_all(targets_selected)
   attack_selection = false
   multi_selection = false

func toggle_attack_selection():
   print_rich("[color=Springgreen]Selection Manager[/color]: attack toggled")
   attack_selection = !attack_selection

func toggle_multi_selection():
   print_rich("[color=Springgreen]Selection Manager[/color]: multi toggled")
   multi_selection = !multi_selection
