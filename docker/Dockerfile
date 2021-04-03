FROM debian:unstable-20210329-slim

# Installing apt-utils first, so we don't run into the warning
# "debconf: delaying package configuration, since apt-utils is not installed"

RUN apt-get update && apt-get install apt-utils && apt-get install -y imagemagick ffmpeg musescore-general-soundfont-lossless fluidsynth
ADD render /usr/bin

CMD ["render"]
