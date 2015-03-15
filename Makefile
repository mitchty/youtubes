.PHONY: all before after diff watch download archive plex
.DEFAULT: all
VIDEOPLAYER=open -a vlc
PLEXSCANNER=/Applications/Plex\ Media\ Server.app/Contents/MacOS/Plex\ Media\ Scanner
FIND=find . -type f -name "*.mp4" -o -name "*.flv" -o -name "*.wmv"
all: download plex

plex: archive diff
	diff before after > /dev/null 2>&1 && false || true
	$(PLEXSCANNER) --scan --refresh --force --section 3

before:
	$(FIND) > before

after:
	$(FIND) > after

diff: after

watch: archive diff
	diff before after > /dev/null 2>&1 && false || true
	$(VIDEOPLAYER) $(shell diff before after | grep '>' | sed -e 's|\> ||g')

download: before
	-youtube-dl --ignore-errors --no-overwrites --continue --output "%(extractor)s-%(upload_date)s-%(uploader)s-%(title)s-%(id)s.%(ext)s" --batch-file urls --restrict-filenames --download-archive archive --format best --no-part

archive:
	./archive.sh
