class_name Action
extends Resource

#TODO implement Action class

var contained
var targets: Array[Entity] = []

func _init(p_contained, p_targets: Array[Entity]) -> void:
   contained = p_contained
   targets = p_targets
   print_rich("[color=green]Action[/color]: contained: ", contained.name, "\ttargets: ", targets)

func _to_string() -> String:
   return str(contained.name) + " " + str(targets)
