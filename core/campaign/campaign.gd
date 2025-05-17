extends Control

#TODO finish functionality of rewards screen
#TODO replace set_player_position with a save resource
#FIXME encounters are skipped on the map

# ---- # Nodes
@onready var encounters: Node = $Encounters
@onready var result_screen: ColorRect = $ResultScreen
@onready var path_2d: Path2D = $CampaignMap/Path2D
@onready var path_follow_2d: PathFollow2D = $CampaignMap/Path2D/PathFollow2D
@onready var player: Sprite2D = $CampaignMap/Path2D/PathFollow2D/PlayerMarker

# ---- # Variables
@onready var points: Array[Vector2]
var map_encounter = preload("res://user_interface/encounter.tscn")
var progress: int = 1

# ---- # Set Player Position
# loop through encounters, move player to them, delete encounter
func set_player_position(encounter_num: int):
   if encounter_num == encounters.get_child_count() - 1:
      Global.party.campaign_position = 0
      Global.party.progress += 1
   for i in encounter_num:
      var child = encounters.get_child(0)
      player.position = child.position
      child.queue_free()
      encounters.remove_child(child)
   result_screen.show()
   get_tree().paused = true

# ---- # Ready
func _ready() -> void:
   if Global.party.icon != null: player.texture = Global.party.icon
   set_player_position(Global.party.campaign_position)

# ---- # Physics process
func _physics_process(delta):
   if result_screen.visible: result_screen.hide()

   path_follow_2d.progress += 100 * delta
   print(encounters.get_child(0).global_position.distance_to(player.global_position))
   if encounters.get_child(0).global_position.distance_to(player.global_position) < 100:
      encounters.get_child(0).load_encounter()
