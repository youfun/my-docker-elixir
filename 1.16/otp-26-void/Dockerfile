FROM hentioe/erlang:26.2.4-void

ARG TARGETARCH

ENV ELIXIR_VERSION="v1.16.2" \
	# elixir expects utf8. \
	LANG=C.UTF-8 \
	# Declare runtime dependencies. \
	RUNTIME_DEPS=' \
	libstdc++ \
	libssl3 \
	lksctp-tools \
	ncurses-libs \
	'

RUN set -xe \
	&& if [ "$TARGETARCH" = "arm64" ]; then \
	# Avoid QEMU/arm64 build failed. \
	export ERL_FLAGS="+JMsingle true"; \
	fi \
	&& ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/${ELIXIR_VERSION}.tar.gz" \
	&& ELIXIR_DOWNLOAD_SHA256="f53d06f3e4041c50e65b750e5d56fec9cc7c6a44510786937c6a5bb0666a7207" \
	&& buildDeps=' \
	curl \
	make \
	glibc-locales \
	' \
	&& xbps-install -Sy \
	&& xbps-install -yu xbps \
	&& xbps-install -Ay $buildDeps \
	# Set locale to C.UTF-8 \
	&& sed -i 's/^#C.UTF-8/C.UTF-8/' /etc/default/libc-locales \
	&& xbps-reconfigure -f glibc-locales \
	# Build and install Elixir \
	&& curl -fSL -o elixir-src.tar.gz $ELIXIR_DOWNLOAD_URL \
	&& echo "$ELIXIR_DOWNLOAD_SHA256  elixir-src.tar.gz" | sha256sum -c - \
	&& mkdir -p /usr/local/src/elixir \
	&& tar -xzC /usr/local/src/elixir --strip-components=1 -f elixir-src.tar.gz \
	&& ( cd /usr/local/src/elixir \
	&& make install clean ) \
	# Clean up \
	&& find /usr/local/src/elixir/ -type f -not -regex "/usr/local/src/elixir/lib/[^\/]*/lib.*" -exec rm -rf {} + \
	&& find /usr/local/src/elixir/ -type d -depth -empty -delete \
	&& xbps-remove -Roy $buildDeps \
	&& rm elixir-src.tar.gz \
	# Install runtime dependencies (must be done after cleaning build dependencies). \
	&& xbps-install -y $RUNTIME_DEPS \
	# Clean up Void Linux environment. \
	&& void-cleanup

CMD ["iex"]