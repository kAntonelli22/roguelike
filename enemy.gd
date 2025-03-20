class_name Enemy
extends Entity


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   super()
   print_rich("[color=Crimson]Enemy Created[/color]")
   add_to_group("Enemy")
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
