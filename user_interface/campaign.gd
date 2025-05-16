extends Control

#TODO finish functionality of rewards screen

# ---- # Nodes
@onready var player := $Player
@onready var nav_agent := $Player/NavAgent
@onready var encounters: Node = $Encounters
@onready var result_screen: ColorRect = $ResultScreen

# ---- # Variables
@onready var points: Array[Vector2]
var map_encounter = preload("res://user_interface/encounter.tscn")
var progress: int = 1

# ---- # Set Player Position
# loop through encounters, move player to them, delete encounter
func set_player_position(encounter_num: int):
   if encounter_num == 0: return
   if encounter_num == encounters.get_child_count() - 1:
      Global.party.campaign_position = 0
      Global.party.progress += 1
      print("end")
   for i in encounter_num:
      var child = encounters.get_child(i)
      player.position = child.position
      child.queue_free()
      encounters.remove_child(child)
   result_screen.show()
   get_tree().paused = true

# ---- # Ready
func _ready() -> void:
   set_player_position(Global.party.campaign_position)
   nav_agent.target_position = Vector2(1085, 310)

# ---- # Physics process
func _physics_process(delta):
   if result_screen.visible: result_screen.hide()
   if NavigationServer2D.map_get_iteration_id(nav_agent.get_navigation_map()) == 0:
      return
   if nav_agent.is_navigation_finished():
      return
   
   var speed = 50 * delta
   var next_path_position: Vector2 = nav_agent.get_next_path_position()
   var new_velocity: Vector2 = player.global_position.direction_to(next_path_position) * speed
   player.global_position = player.global_position.move_toward(player.global_position + new_velocity, speed)
