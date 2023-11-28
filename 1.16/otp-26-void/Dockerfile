FROM hentioe/erlang:26.1.2-void

ARG ERL_FLAGS=""

ENV ELIXIR_VERSION="v1.16.0-rc.0" \
	# set flags from build_arg.
	ERL_FLAGS=$ERL_FLAGS \
	# elixir expects utf8.
	LANG=C.UTF-8 

RUN set -xe \
	&& ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/${ELIXIR_VERSION}.tar.gz" \
	&& ELIXIR_DOWNLOAD_SHA256="2dfbe017ccff1b05cacf80d7204b088ab438ec6ff1311a3bd9d33ceb2c26674e" \
	&& runtimeDeps=' \
	libstdc++ \
	libssl3 \
	lksctp-tools \
	ncurses-libs \
	' \
	&& buildDeps=' \
	curl \
	make \
	glibc-locales \
	' \
	&& xbps-install -Sy \
	&& xbps-install -y $buildDeps \
	# Set locale to C.UTF-8
	&& sed -i 's/^#C.UTF-8/C.UTF-8/' /etc/default/libc-locales \
	&& xbps-reconfigure -f glibc-locales \
	# Build and install Elixir
	&& curl -fSL -o elixir-src.tar.gz $ELIXIR_DOWNLOAD_URL \
	&& echo "$ELIXIR_DOWNLOAD_SHA256  elixir-src.tar.gz" | sha256sum -c - \
	&& mkdir -p /usr/local/src/elixir \
	&& tar -xzC /usr/local/src/elixir --strip-components=1 -f elixir-src.tar.gz \
	&& ( cd /usr/local/src/elixir \
	&& make install clean ) \
	# Clean up
	&& find /usr/local/src/elixir/ -type f -not -regex "/usr/local/src/elixir/lib/[^\/]*/lib.*" -exec rm -rf {} + \
	&& find /usr/local/src/elixir/ -type d -depth -empty -delete \
	&& xbps-remove -ROoy $buildDeps \
	# Install runtime dependencies in the back door to avoid being removed by association.
	&& xbps-install -y $runtimeDeps \ 
	&& rm elixir-src.tar.gz \
	&& rm -f /tmp/jit-*.dump /tmp/perf-*.map \
	&& void-cleanup

CMD ["iex"]