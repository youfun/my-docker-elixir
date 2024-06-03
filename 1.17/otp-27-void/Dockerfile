FROM hentioe/erlang:27.0-void

ARG TARGETARCH

ENV ELIXIR_VERSION="v1.17.0-rc.1" \
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
	&& ELIXIR_DOWNLOAD_SHA256="69e066a6bf3b96d87c8f544343de0a5cb87cbdbbb56fedff86ea1b47aefdf0f3" \
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