################################################################################
#
# libsodium-new
#
################################################################################

LIBSODIUM_NEW_VERSION = 1.0.20
LIBSODIUM_NEW_SITE = https://download.libsodium.org/libsodium/releases
LIBSODIUM_NEW_SOURCE = libsodium-$(LIBSODIUM_NEW_VERSION).tar.gz
LIBSODIUM_NEW_LICENSE = ISC
LIBSODIUM_NEW_LICENSE_FILES = LICENSE
LIBSODIUM_NEW_INSTALL_STAGING = YES

ifeq ($(BR2_TOOLCHAIN_SUPPORTS_PIE),)
LIBSODIUM_NEW_CONF_OPTS += --disable-pie
endif

ifeq ($(BR2_PACKAGE_LIBSODIUM_NEW_FULL),y)
LIBSODIUM_NEW_CONF_OPTS += --disable-minimal
else
LIBSODIUM_NEW_CONF_OPTS += --enable-minimal
endif

$(eval $(autotools-package))
$(eval $(host-autotools-package))
