################################################################################
#
# tiny-websocket
#
################################################################################


TINY_WEBSOCKET_VERSION = 1.1.1
TINY_WEBSOCKET_SITE = https://github.com/chemwolf6922/tiny-websocket
TINY_WEBSOCKET_SITE_METHOD = git
TINY_WEBSOCKET_GIT_SUBMODULES = YES
TINY_WEBSOCKET_INSTALL_STAGING = YES
TINY_WEBSOCKET_INSTALL_TARGET = YES

$(eval $(cmake-package))
