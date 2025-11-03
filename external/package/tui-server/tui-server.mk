################################################################################
#
# tui-server
#
################################################################################


TUI_SERVER_VERSION = 375f4117b2e40088f93c72a92885a0a978508041
TUI_SERVER_SITE = https://github.com/tiny-webui/server.git
TUI_SERVER_SITE_METHOD = git
TUI_SERVER_INSTALL_STAGING = NO
TUI_SERVER_INSTALL_TARGET = YES
TUI_SERVER_DEPENDENCIES = libcurl libwebsockets sqlite util-linux libsodium-new json-for-modern-cpp tev-cpp js-style-co-routine

$(eval $(cmake-package))
