/client/proc/read_world_log(log,portion)
	src<< "The logfile is being downloaded. Please be patient. Any lag is due to the download and is limited to just you."
	src<<browse(file(log), "window=Log;size=600x600")  ///   <<----- This is what makes the pop up src<<browse(file(log)) is with no pop up
	src<<ftp(file(log))