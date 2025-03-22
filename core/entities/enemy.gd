class_name Enemy
extends Entity


# ---- # Variables


func _ready() -> void:
   super()
   print_rich("[color=Crimson]Enemy Created[/color]")
   add_to_group("Enemy")
   icon = Global.godot_icon
   health = 100
   action_points = 100
   await SignalBus.battle_ready
   SignalBus.emit_signal("new_enemy", self)

func _state_logic(_delta):
   if !my_turn: return
   else: enemy_turn()
   super(_delta)
   
func _get_transition(_delta):
   super(_delta)

# ---- # Enemy Turn
#TODO create basic enemy turn logic
func enemy_turn():
   print_rich("[color=Crimson]Enemy[/color]:[color=#AAAAAA]starting turn[/color]")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
   super(viewport, event, shape_idx)
   if event.is_action_pressed("select"): print_rich("[color=Crimson]Enemy[/color]: selected")
