#' zar_tracks
#'
#' @return
#' @export
#'
#' @examples
zar_tracks <-
	function(data,
					 crs,
					 rate,
					 tolerance,
					 n_random_steps,
					 packages = targets::tar_option_get("packages"),
					 library = targets::tar_option_get("library"),
					 format = "qs",
					 error = targets::tar_option_get("error"),
					 memory = targets::tar_option_get("memory"),
					 garbage_collection = targets::tar_option_get("garbage_collection"),
					 deployment = targets::tar_option_get("deployment"),
					 priority = targets::tar_option_get("priority"),
					 cue = targets::tar_option_get("cue")) {
		name <- 'locs'

		name_tracks_raw <- paste(name, 'tracks', 'raw', sep = '_')
		name_tracks <- paste(name, 'tracks', sep = '_')
		name_resample <- paste(name, 'resample', sep = '_')
		name_random <- paste(name, 'random', sep = '_')

		command_tracks_raw <- substitute(data)
		command_tracks <- substitute(
			make_track(tracks, x_, y_, t_, all_cols = TRUE, crs = crs),
			env = list(tracks = as.symbol(name_tracks_raw), crs = crs)
		)
		command_resample <- substitute(
			resample_tracks(tracks, rate = rate, tolerance = tolerance),
			env = list(tracks = as.symbol(name_tracks),
								 rate = rate,
								 tolerance = tolerance)
		)
		command_random <- substitute(
			random_steps(resampled, n = n_random_steps),
			env = list(resampled = as.symbol(name_resample),
								 n_random_steps = n_random_steps)
		)

		pattern_tracks_raw <- substitute(data)
		pattern_tracks <- substitute(x, env = list(x = as.symbol(name_tracks_raw)))
		pattern_resample <- substitute(x, env = list(x = as.symbol(name_tracks)))
		pattern_random <- substitute(x, env = list(x = as.symbol(name_resample)))


		target_tracks_raw <- get_target_raw(name_tracks_raw, command_tracks_raw,
																				pattern = pattern_tracks_raw)
		target_tracks <- get_target_raw(name_tracks, command_tracks,
																		pattern = pattern_tracks)
		target_resample <- get_target_raw(name_resample, command_resample,
																			pattern = pattern_resample)
		target_random <- get_target_raw(name_random, command_random,
																		pattern = pattern_random)

		return(list(
			target_tracks_raw,
			target_tracks,
			target_resample,
			target_random
		))
	}

