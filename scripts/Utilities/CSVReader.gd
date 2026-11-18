class_name CSVReader

var result : Dictionary[String, Array]
var headers : PackedStringArray
var path : String

func _init(file_path: String) -> void:
	var file : FileAccess = FileAccess.open(file_path, FileAccess.READ)
	if !file:
		push_error(file_path, " does not exist.")
		
	path = file_path
	
	headers = file.get_csv_line()
	for current_header : String in headers:
		result[current_header] = []
	
	while !file.eof_reached():
		var elements : PackedStringArray = file.get_csv_line()
		for i : int in range(len(elements)):
			var element : String = elements[i]
			
			result[headers[i]].append(element)
	file.close()

#region Methods
func get_record_from_row_index(row_index : int) -> PackedStringArray:
	if row_index < 0 or row_index >= len(result[headers[0]]):
		push_error("Attempt to access row index", row_index,", which is out of bounds.")
		
	var record : PackedStringArray
	
	for i : int in range(len(result)):
		var element : String = result[headers[i]][row_index]
		@warning_ignore("return_value_discarded")
		record.append(element)
	
	return record
	
func get_row_index(row : String) -> int:
	var row_index : int = result[headers[0]].find(row)
	
	if row_index == -1:
		push_warning("Row ",row," does not exist in ",path)
		return -1
		
	return row_index
	
func get_record_from_row(row : String) -> PackedStringArray:
	return get_record_from_row_index(get_row_index(row))
	
func get_column_from_record(column: String, record : PackedStringArray) -> String:
	var column_index : int = headers.find(column)
	if column_index == -1:
		push_warning("Header ",column," does not exist in ",path)
		return ""
		
	return record[column_index]

func get_element_from_row_column(row: String, column: String) -> String:
	var column_array : PackedStringArray = result.get(column)
	if !column_array:
		push_error("Column ",column," does not exist in ",path)

	var row_index : int = get_row_index(row)
	
	if row_index == -1:
		push_error("Row ",row," does not exist in ", path)
	
	return column_array[row_index]
	
func set_element_from_row_column(element: String, row: String, column: String) -> void:
	var column_array : PackedStringArray = result.get(column)
	if !column_array:
		push_error("Column ",column," does not exist in ",path)

	var row_index : int = get_row_index(row)
	
	if row_index == -1:
		push_error("Row ",row," does not exist in ", path)
	
	column_array[row_index] = element
#endregion
