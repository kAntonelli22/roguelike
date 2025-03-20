extends CanvasLayer


# ---- # Nodes
@onready var turn_queue = $MarginContainer/TurnQueue
@onready var end_turn = $MarginContainer/EndTurn

# ---- # Next Turn
func next_turn():
   turn_queue.move_child(turn_queue.get_child(0), turn_queue.get_child_count())

func update_queue(queue: Array[Entity]):
   for entity in queue:
      #var icon = new ColorRect  #TODO add icon data to entities and retrieve it here
      turn_queue#.add_child(icon)

func _on_end_turn_pressed() -> void:
   SignalBus.emit_signal("end_turn")
