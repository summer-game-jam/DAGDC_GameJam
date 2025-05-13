extends Entity
class_name Spwaner

# doesn't logicaly create a robot, instead acts as a natural way of adding a robot actor to the stage
# animation code here
func spwan_robot(robot: Playable_Robot):
	robot.global_position = global_position
