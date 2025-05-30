extends Node
class_name StateMachine
# children inherit state machine and add custom states in ready function
# abstract state machine handles transitions between states

var state = null
var previous_state = null
var states = {}

@onready var parent = get_parent()

func _physics_process(delta: float) -> void:
   if state != null:
      _state_logic(delta)
      var transition = _get_transition(delta)
      if transition != null: set_state(transition)
   
func _state_logic(_delta): pass
func _get_transition(_delta): return null
func _enter_state(_new_state, _old_state): pass
func _exit_state(_old_state, _new_state): pass

func set_state(new_state):
   #Util.print(["switching from ", states.keys()[state] if state != null else "null", " state to ", states.keys()[new_state]])
   previous_state = state
   state = new_state
   if previous_state != null: _exit_state(previous_state, new_state)
   if new_state != null: _enter_state(new_state, previous_state)

func add_state(state_name: String):
   states[state_name] = states.size()
