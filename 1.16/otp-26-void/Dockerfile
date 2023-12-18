FROM hentioe/erlang:26.2.1-void

ARG ERL_FLAGS=""

ENV ELIXIR_VERSION="v1.16.0-rc.1" \
	# elixir expects utf8.
	LANG=C.UTF-8 \
	# set flags from build_arg.
	ERL_FLAGS=$ERL_FLAGS \
	# Declare runtime dependencies.
	RUNTIME_DEPS=' \
	libstdc++ \
	libssl3 \
	lksctp-tools \
	ncurses-libs \
	'

RUN set -xe \
	&& ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/${ELIXIR_VERSION}.tar.gz" \
	&& ELIXIR_DOWNLOAD_SHA256="057aca982fd840f2e01c2d60e51523d6870e6937bea58f0e0860d118b7ca2de4" \
	&& buildDeps=' \
	curl \
	make \
	glibc-locales \
	' \
	&& xbps-install -Sy \
	&& xbps-install -Ay $buildDeps \
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
	&& xbps-remove -Roy $buildDeps \
	# Install runtime dependencies (must be done after cleaning build dependencies).
	&& xbps-install -y $RUNTIME_DEPS \ 
	&& rm elixir-src.tar.gz \
	&& rm -f /tmp/jit-*.dump /tmp/perf-*.map \
	&& void-cleanup

CMD ["iex"]