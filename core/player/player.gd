class_name Player
extends Entity

# ---- # Variables


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   super()
   print_rich("[color=Royalblue]Player Created[/color]")
   add_to_group("Player")
   health = Global.player_stats.health
   action_points = Global.player_stats.action_points
   await SignalBus.battle_ready
   SignalBus.emit_signal("new_player", self)
   

func _state_logic(_delta):
   if !my_turn: return
   super(_delta)
   
func _get_transition(_delta):
   super(_delta)

func _input(event: InputEvent) -> void:
   if !my_turn: return
   if event.is_action_pressed("ui_up"): set_state(states.attack)
   elif event.is_action_pressed("ui_down"): set_state(states.dead)
   
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
   super(viewport, event, shape_idx)   # FIXME parent code does not run
