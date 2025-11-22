################################################################################
#
# tui-server
#
################################################################################


TUI_SERVER_VERSION = 0.1.0
TUI_SERVER_SITE = https://github.com/tiny-webui/server.git
TUI_SERVER_SITE_METHOD = git
TUI_SERVER_INSTALL_STAGING = NO
TUI_SERVER_INSTALL_TARGET = YES
TUI_SERVER_DEPENDENCIES = libcurl libwebsockets sqlite util-linux libsodium-new json-for-modern-cpp tev-cpp js-style-co-routine

$(eval $(cmake-package))
