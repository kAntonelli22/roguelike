class_name Enemy
extends Entity

#TODO actually use the state machine for more than just animations
# ---- # Variables

func create_actions():
   for i in range(0, attacks.size()):
      var button = Button.new()
      button.text = attacks[i].name + " " + str(attacks[i].damage_min) + "-" + str(attacks[i].damage_max)
      button.name = str(i)
      action_selection.add_child(button)
      #button.pressed.connect(attack_num.bind(button))

func _ready() -> void:
   super()
   add_to_group("Enemy")
   health = 50
   action_points = 3
   $SelectionRing.modulate = Color(1, 0, 0)
   await SignalBus.battle_ready
   SignalBus.emit_signal("new_enemy", self)

func _state_logic(_delta):
   if my_turn and state == states.idle: enemy_turn()
   super(_delta)
   
func _get_transition(_delta):
   match(state):
      states.idle:
         pass
      states.attack:
         pass
      states.hurt:
         pass
   var super_transition = super(_delta)
   if super_transition != null: return super_transition

# ---- # Exit State
func _exit_state(previous_state, new_state):
   if previous_state == states.attack: end_turn()

# ---- # Enemy Turn
#TODO create basic enemy turn logic
func enemy_turn():
   var target: Entity = get_parent().player_entities.pick_random()   #HACK code is innefficient and breaks signal up structure
   var attack: Attack = attacks.pick_random()
   attack.attack([target])
   set_state(states.attack)

func end_turn():
   SignalBus.emit_signal("end_turn")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
   super(viewport, event, shape_idx)
   
