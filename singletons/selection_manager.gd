extends Node


# ---- # Variables
var entities_selected: Array[Entity] = []
var targets_selected: Array[Entity] = []

func _ready() -> void:
   SignalBus.connect("selected", select_entity)
   SignalBus.connect("action", attack_select_entity)
   SignalBus.connect("end_turn", reset)

func attack_select_entity(entity: Entity):
   if targets_selected.has(entity):
      targets_selected.remove_at(targets_selected.find(entity))
      entity.attack_deselect()
      return

   targets_selected.append(entity)
   entity.attack_select()
   Util.print(["target selected"])
   SignalBus.emit_signal("target_selected", entity)

func select_entity(entity: Entity):
   if entities_selected.has(entity):
      entities_selected.remove_at(entities_selected.find(entity))
      entity.deselect()
      return
   
   deselect_all(entities_selected)
   entities_selected.append(entity)
   entity.select()

func deselect_all(array):
   #Util.print(["clearing array"])
   for element in array:
         element.deselect()
         element.attack_deselect()
   array.clear()

func get_targets() -> Array[Entity]:
   Util.print(["providing target array duplicate"])
   var array = targets_selected.duplicate()
   deselect_all(targets_selected)
   return array

func set_targets(new_targets: Array[Entity]) -> void:
   targets_selected = new_targets

func reset():
   deselect_all(entities_selected)
   deselect_all(targets_selected)

func _to_string() -> String:
   var string: String = "SelectionManager\n"
   string += "\ttargets: " + str(targets_selected) + "\tentities: " + str(entities_selected)
   return string
   
