class_name Player
extends Entity

#TODO switch to using target array to hold enemies that will be attacked
#TODO actually use the state machine for more than just animations

# ---- # Nodes
@onready var action_selection = $ActionSelection

# ---- # Variables
var current_attack: Attack

func select():
   super()
   action_selection.show()

func deselect():
   super()
   current_attack = null
   action_selection.hide()

func create_actions():
   for i in range(0, attacks.size()):
      var button = Button.new()
      button.text = attacks[i].name + " " + str(attacks[i].damage_min) + "-" + str(attacks[i].damage_max)
      button.name = str(i)
      action_selection.add_child(button)
      button.pressed.connect(attack_num.bind(button))

func attack_num(button):
   print_rich("[color=Royalblue]Player[/color]: attack ", button.text, " chosen")
   var new_attack = attacks[button.name.to_int()]
   if current_attack == new_attack: 
      current_attack = null
   else:
      current_attack = new_attack
      SelectionManager.attack_selection = true
      if current_attack is Attack.MultiTargetAttack: SelectionManager.multi_selection = true

func finish_turn(signaller: Entity):
   #HACK signaller is added to deal with weird signal behavior
   if !my_turn or signaller != self: return
   if action_points > 0 and current_attack != null:
      current_attack.attack(SelectionManager.get_targets())
      set_state(states.attack)
   else: print_rich("[color=Royalblue]Player[/color]: not enough action points: ", action_points)
   SignalBus.emit_signal("end_turn")

func _ready() -> void:
   base_class = Global.player_stats.base_class
   super()
   add_to_group("Player")
   health = Global.player_stats.health
   action_points = Global.player_stats.action_points
   SignalBus.connect("turn_button_pressed", finish_turn)
   create_actions()
   await SignalBus.battle_ready
   SignalBus.emit_signal("new_player", self)
   

func _state_logic(_delta):
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

func _input(event: InputEvent) -> void:
   if !my_turn: return
   if event.is_action_pressed("ui_up"): set_state(states.attack)
   elif event.is_action_pressed("ui_down"): set_state(states.dead)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
   super(viewport, event, shape_idx)
