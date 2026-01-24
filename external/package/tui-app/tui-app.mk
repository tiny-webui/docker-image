################################################################################
#
# tui-app
#
################################################################################

TUI_APP_VERSION = 0.1.7
TUI_APP_SITE = https://github.com/tiny-webui/webapp.git
TUI_APP_SITE_METHOD = git
TUI_APP_GIT_SUBMODULES = YES
TUI_APP_INSTALL_STAGING = NO
TUI_APP_INSTALL_TARGET = YES

define TUI_APP_BUILD_CMDS
	npm i --prefix $(@D)
	npm run build --prefix $(@D)
endef

# TODO: pre gzip the appropriate files
define TUI_APP_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/share/tui-app
	cp -r $(@D)/out/* $(TARGET_DIR)/usr/share/tui-app/
endef

$(eval $(generic-package))
