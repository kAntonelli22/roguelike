class_name Player
extends Entity

#TODO actually use the state machine for more than just animations

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
   current_attack = new_attack if current_attack != new_attack else null
   SelectionManager.attack_selection = current_attack != null
   SelectionManager.multi_selection = new_attack is Attack.MultiTarget

func add_action():
   if my_turn: super()

func finish_turn(signaller: Entity):
   #HACK signaller is added to deal with weird signal behavior
   if my_turn and signaller == self: start_turn()

func _ready() -> void:
   base_class = Global.player_stats.base_class
   super()
   add_to_group("Player")
   health = Global.player_stats.health
   action_points = Global.player_stats.action_points
   SignalBus.connect("turn_button_pressed", finish_turn)
   SignalBus.connect("confirm_attack", add_action)
   create_actions()
   await SignalBus.battle_ready
   SignalBus.emit_signal("new_player", self)

func _state_logic(_delta):
   super(_delta)
   
func _get_transition(_delta):
   var super_transition = super(_delta)
   if super_transition != null: return super_transition

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
   super(viewport, event, shape_idx)
