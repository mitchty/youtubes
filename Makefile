.PHONY: all before after diff watch download archive
.DEFAULT: all
VIDEOPLAYER=open -a vlc

all: download watch

before:
	find . -type f -name "*.mp4" > before

after:
	find . -type f -name "*.mp4" > after

diff: after

watch: archive diff
	$(VIDEOPLAYER) $(shell diff before after | grep '>' | sed -e 's|\> ||g')

download: before
	-youtube-dl --ignore-errors --no-overwrites --continue --output "%(extractor)s-%(upload_date)s-%(uploader)s-%(title)s-%(id)s-%(resolution)s.%(ext)s" --batch-file urls --youtube-skip-dash-manifest --restrict-filenames --download-archive archive --format best

archive:
	./archive.sh
