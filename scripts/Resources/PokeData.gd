class_name PokeData
extends Resource

#region Constants
enum UNIT {
	Metric,
	Imperial
}
const METRE_TO_FEET_FACTOR : float = 3.28084
const FEET_TO_INCHES_FACTOR : float = 12.0
const KILO_TO_LBS_FACTOR : float = 2.204623
#endregion

#region Exports
@export var species : String
#height and weight is stored as metres and kilograms respectively
@export var height : float
@export var weight : float
#endregion

#region Methods
func get_string_height(unit : UNIT) -> String:
	match unit:
		UNIT.Metric:
			return "%.2fm" % height
		UNIT.Imperial:
			var feet : float = floorf(height * METRE_TO_FEET_FACTOR)
			var inches : float = (height * METRE_TO_FEET_FACTOR - feet)*FEET_TO_INCHES_FACTOR
			return "%.0f\'%02f\"" % [feet, inches]
		_:
			#how did u get here???
			push_error("something very very wrong has occurred")
			return "ERRNO"
	
func get_string_weight(unit : UNIT) -> String:
	match unit:
		UNIT.Metric:
			return "%.1fkg" % weight
		UNIT.Imperial:
			return "%.1flbs" % (weight * KILO_TO_LBS_FACTOR)
		_:
			#how did u get here???
			push_error("something very very wrong has occurred")
			return "ERRNO"
#endregion
