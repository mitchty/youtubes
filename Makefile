.PHONY: all before after diff watch download
.DEFAULT: all
VIDEOPLAYER=open -a vlc

all: download watch

before:
	ls youtube-* > before

after:
	ls youtube-* > after

diff: after

watch: diff
	$(VIDEOPLAYER) $(shell diff before after | grep '>' | sed -e 's|\> ||g')

download: before
	-youtube-dl --ignore-errors --no-overwrites --continue --output "%(extractor)s-%(upload_date)s-%(uploader)s-%(title)s-%(id)s-%(resolution)s.%(ext)s" --batch-file urls --youtube-skip-dash-manifest --restrict-filenames --download-archive archive --format best
