################################################################################
#
# tui-server
#
################################################################################


TUI_SERVER_VERSION = 76e15bd8422fe4458b8c7a1595fbbe1743241c72
TUI_SERVER_SITE = https://github.com/tiny-webui/server.git
TUI_SERVER_SITE_METHOD = git
TUI_SERVER_INSTALL_STAGING = NO
TUI_SERVER_INSTALL_TARGET = YES
TUI_SERVER_DEPENDENCIES = libcurl libwebsockets sqlite util-linux libsodium-new json-for-modern-cpp tev-cpp js-style-co-routine

$(eval $(cmake-package))
