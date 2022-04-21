get_target_raw <- function(name, command, pattern = NULL) {
	tar_target_raw(
		name = name,
		command = command,
		pattern = pattern,
		packages = targets::tar_option_get("packages"),
		library = targets::tar_option_get("library"),
		format = "qs",
		error = targets::tar_option_get("error"),
		memory = targets::tar_option_get("memory"),
		garbage_collection = targets::tar_option_get("garbage_collection"),
		deployment = targets::tar_option_get("deployment"),
		priority = targets::tar_option_get("priority")
	)
}
