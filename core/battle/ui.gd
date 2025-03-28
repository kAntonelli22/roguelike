extends CanvasLayer


# ---- # Nodes
@onready var turn_queue := $MarginContainer/TurnQueue
@onready var remaining_points := $MarginContainer/TurnContainer/PointsRemaining
@onready var turn_button := $MarginContainer/TurnContainer/EndTurn
@onready var parent = get_parent()

# ---- # Next Turn
func next_turn(disable_turn_button: bool):
   turn_button.disabled = disable_turn_button
   turn_queue.move_child(turn_queue.get_child(0), turn_queue.get_child_count())

func update_queue(queue: Array[Entity]):
   for entity in queue:
      var icon: TextureRect = TextureRect.new()
      icon.texture = entity.icon
      icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH
      icon.name = entity.name
      icon.tooltip_text = entity.name
      turn_queue.add_child(icon)

# ---- # Remove From Queue
func remove_from_queue(entity: Entity):
   turn_queue.remove_child(turn_queue.get_node(str(entity.name)))

func _on_end_turn_pressed() -> void:
   if parent.current_entity.current_attack == null and !remaining_points.visible:
      remaining_points.show()
   else:
      turn_button.disabled = true
      remaining_points.hide()
      SignalBus.emit_signal("turn_button_pressed", parent.current_entity)


func _on_confirm_attack_pressed() -> void:
   SignalBus.emit_signal("confirm_attack")
