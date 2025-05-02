class_name Entity
extends StateMachine

#TODO display damage when attack is selected and entity is hovered over
#FIXME sprite does not transition out of hurt state until end of turn
#FIXME sprite frames need to be adjusted

# ---- # Nodes
@onready var sprite := $Sprite
@onready var healthbar := $Healthbar
@onready var selection_ring := $SelectionRing
@onready var attack_ring := $AttackRing
@onready var action_selection = $ActionSelection

# ---- # Stat Const
var ACTIONS: int = 3
var HEALTH: int = 100
var SPEED: int = 3


# ---- # Variables
var icon 
var is_selected: bool = false
var is_target: bool = false
var my_turn: bool = false        # changed by the battle scene

var base_class: String = "Knight"
var health: int = 100
var actions: int = 3
var speed: int             # used to determine turn order

var current_attack: Attack
var attacks: Array
var effects: Array
var action_queue: Array[Action]

func select():
   is_selected = true
   selection_ring.show()
   action_selection.show()
func deselect():
   is_selected = false
   current_attack = null
   selection_ring.hide()
   action_selection.hide()

func attack_select():
   is_target = true
   attack_ring.show()
func attack_deselect():
   is_target = true
   attack_ring.hide()

func apply_damage(damage):
   Util.print(["took ", damage, " damage"])
   health -= damage
   health = clamp(health, 0, HEALTH)
   healthbar.value = health
   if health <= 0:set_state(states.dead)
   else: set_state(states.hurt)

func start_turn():
   if action_queue.is_empty(): end_turn()
   else: do_action(action_queue.pop_front())
func end_turn():
   Util.print(["ending turn"], self.name)
   set_state(states.idle)     #HACK should be in get_transition
   actions = ACTIONS
   SignalBus.emit_signal("end_turn")

func add_action():
   action_queue.push_back(Action.new(current_attack, SelectionManager.get_targets()))
   #if actions - current_attack.cost >= 0:
      #actions -= current_attack.cost
      #action_queue.push_back(Action.new(current_attack, SelectionManager.get_targets()))
   #else:
      #current_attack = null
      #SelectionManager.deselect_all(SelectionManager.targets_selected)
   
func do_action(action: Action):
   if action.contained is Effect:
      action.contained.effect(self)
   if action.contained is Attack:
      action.contained.attack(action.targets)
      set_state(states.attack)

func _ready() -> void:
   Util.print(["Entity created"])
   sprite.sprite_frames = Global.classes[base_class]["sprite"]
   icon = Global.classes[base_class]["icon"]
   attacks = Global.classes[base_class]["attacks"]
   add_to_group("Entity")
   add_state("idle")
   add_state("attack")
   add_state("hurt")
   add_state("dead")
   set_state(states.idle)
   speed = get_tree().get_nodes_in_group("Entity").size()

func _state_logic(_delta):
   healthbar.tooltip_text = _to_string()
   
func _get_transition(_delta):
   if !sprite.is_playing() and state != states.dead: return states.idle     #FIXME doesnt reset

func _enter_state(new_state, old_state):
   sprite.play(states.keys()[new_state])
   if new_state == states.dead: SignalBus.emit_signal("entity_died", self)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
   if event.is_action_pressed("select"):
      SignalBus.emit_signal("selected", self)
   if event.is_action_pressed("action"):
      SignalBus.emit_signal("action", self)

func _on_sprite_animation_finished() -> void:
   if my_turn:
      if action_queue.is_empty(): end_turn()
      else: do_action(action_queue.pop_front())

func _to_string() -> String:
   #var string = "is_selected: " + str(is_selected) + "   my_turn: " + str(my_turn)
   #string += " health: " + str(health) + "   actions: " + str(actions)
   #string += "\naction_queue: " + str(action_queue) + "  current_attack: " + str(current_attack)
   #string += "\nattacks: " + str(attacks) + "\neffects: " + str(effects) + "\ntargets: " + str(targets)
   return name#string
