extends Node


# ---- # Battle Signals
signal battle_ready     # emitted by battle scene when it has connected its signals
signal turn_button_pressed    # called by the turn button when the player presses it

# ---- # Entity Signals
signal new_player(player: Player)   # called by player in ready function
signal new_enemy(enemy: Enemy)      # called by enemy in ready function
signal entity_died(entity: Entity)  # called by entities when they die
signal end_turn(entity: Entity)     # called by a child of the batle scene when its turn is completed
signal selected(entity: Entity)     # called by an entity when the player selects them

func _ready() -> void:
   pass
   #connect("turn_button_pressed", debug)
#
#func debug():
   #print("signal received")
