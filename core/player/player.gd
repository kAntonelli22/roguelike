class_name Player
extends Entity

#TODO action selection separation and button creation in code
# ---- # Nodes
@onready var action_selection = $ActionSelection

# ---- # Variables

func toggle_selected():
   super()
   action_selection.visible = !action_selection.visible

func _ready() -> void:
   super()
   print_rich("[color=Royalblue]Player Created[/color]")
   add_to_group("Player")
   icon = Global.godot_icon
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

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
   super(viewport, event, shape_idx)
   if event.is_action_pressed("select"): print_rich("[color=Royalblue]Player[/color]: selected")
