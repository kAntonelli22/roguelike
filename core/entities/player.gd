class_name Player
extends Entity

#FIXME spam clicking can cause errors
#FIXME multi target attacks cannot be used with less than max
#FIXME attack logic should be in attack class

# ---- # Create Actions
# loops through attacks and creates a button for each
func create_actions():
   for i in range(0, attacks.size()):
      var button = Button.new()
      button.text = attacks[i].name + " " + str(attacks[i].damage_min) + "-" + str(attacks[i].damage_max)
      button.name = str(i)
      action_selection.add_child(button)
      button.pressed.connect(set_attack.bind(button))

func set_attack(button):
   current_attack = attacks[button.name.to_int()]

# ---- # Attack
#HACK should be in entity and overwritten by player and enemy
func attack(target: Entity):
   if !my_turn or current_attack == null: return
   Util.print(["attack ", current_attack, "   t count: ", SelectionManager.targets_selected.size(), "/", current_attack.target_count], self.name)
   if SelectionManager.targets_selected.size() >= current_attack.target_count and current_attack.cost <= actions:
      actions -= current_attack.cost
      current_attack.attack(SelectionManager.get_targets())
      #current_attack = null
      set_state(states.attack)

func add_action():
   if my_turn: super()

func finish_turn(signaller: Entity):
   #HACK signaller is added to deal with weird signal behavior
   Util.print(["finish turn triggered, my turn ", my_turn, "   signaller ", signaller.name], self.name)
   if my_turn and signaller == self: start_turn()

func _ready() -> void:
   base_class = Global.player_stats.base_class
   super()
   add_to_group("Player")
   health = Global.player_stats.health
   actions = Global.player_stats.actions
   SignalBus.connect("turn_button_pressed", finish_turn)
   SignalBus.connect("target_selected", attack)
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
