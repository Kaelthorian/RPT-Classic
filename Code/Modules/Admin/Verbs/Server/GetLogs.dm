/client/proc/get_log(log,portion)
	src<< "The logfile is being downloaded. Please be patient. Any lag is due to the download and is limited to just you."
	src<< "If you want the HTML to WORK, save the .log extension to .html (so it'll be something like ginseng.html)."
	src<<browse(file(log), "window=Log;size=600x600")  ///   <<----- This is what makes the pop up src<<browse(file(log)) is with no pop up
	src<<ftp(file(log))