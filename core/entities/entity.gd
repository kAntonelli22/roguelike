class_name Entity
extends StateMachine

#TODO entity effect array and method that calls each effect
#TODO rework of attack system
#TODO overhaul system to allow for multiple attacks and utilize state machine
#TODO or implement an action queue for each entity that allows it to use the same system but do multiple actions
#FIXME sprite frames need to be adjusted

# ---- # Nodes
@onready var sprite := $Sprite
@onready var healthbar := $Healthbar
@onready var selection_ring := $SelectionRing
@onready var attack_ring := $AttackRing
@onready var action_selection = $ActionSelection

# ---- # Variables
var icon 
var is_selected: bool = false
var my_turn: bool = false        # changed by the battle scene

var base_class: String = "Knight"
var health: int = 100
var action_points: int = 3
var speed: int             # used to determine turn order
var attacks: Array
var effects: Array

func select():
   is_selected = true
   selection_ring.show()
   action_selection.show()

func deselect():
   is_selected = false
   selection_ring.hide()
   action_selection.hide()

func attack_select(): attack_ring.show()
func attack_deselect(): attack_ring.hide()

func apply_damage(damage):
   print_rich("[color=#64649E]Entity[/color]: took ", damage, "damage")
   health -= damage
   set_state(states.hurt)

func _ready() -> void:
   print_rich("[color=#64649E]Entity Created[/color]")
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
   $DebugLabel.text = "effects: " + str(effects)
   if healthbar.value != health: healthbar.value = health
   if health <= 0 and state != states.dead: set_state(states.dead)
   match(state):
      states.idle:
         pass#if sprite.animation != "idle": sprite.play("idle")
      states.attack:
         pass#if sprite.animation != "attack": sprite.play("attack")
      states.hurt:
         pass#if sprite.animation != "hurt": sprite.play("hurt")
      states.dead:
         pass#if sprite.animation != "die" and sprite.is_playing(): sprite.play("die")
   
func _get_transition(_delta):
   match(state):
      states.idle:
         pass
      states.attack:
         if states.attack and sprite.animation != "attack":
            return states.idle
      states.hurt:
         if states.attack and sprite.animation != "hurt":
            return states.idle

func _enter_state(new_state, old_state):
   sprite.play(states.keys()[new_state])
   if new_state == states.dead: SignalBus.emit_signal("entity_died", self)

func _on_knight_sprite_animation_looped() -> void:
   if state == states.attack or state == states.hurt: set_state(states.idle)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
   if event.is_action_pressed("select"):
      if !is_selected: SignalBus.emit_signal("selected", self)
