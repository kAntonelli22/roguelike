class_name Enemy
extends Entity

#FIXME make enemy wait for animation to end before ending turn
# ---- # Variables


func _ready() -> void:
   super()
   print_rich("[color=Crimson]Enemy Created[/color]")
   add_to_group("Enemy")
   health = 100
   action_points = 100
   await SignalBus.battle_ready
   SignalBus.emit_signal("new_enemy", self)

func _state_logic(_delta):
   if my_turn: enemy_turn()
   super(_delta)
   
func _get_transition(_delta):
   super(_delta)

# ---- # Enemy Turn
#TODO create basic enemy turn logic
func enemy_turn():
   var target: Entity = get_tree().get_nodes_in_group("Player").pick_random()
   var attack: Attack = attacks.pick_random()
   attack.attack([target])
   set_state(states.attack)
   my_turn = false
   SignalBus.emit_signal("end_turn")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
   super(viewport, event, shape_idx)
   if event.is_action_pressed("select") and !is_selected: print_rich("[color=Crimson]Enemy[/color]: selected")
   elif event.is_action_pressed("select") and is_selected: print_rich("[color=Crimson]Enemy[/color]: deselected")
