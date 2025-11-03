################################################################################
#
# tev-cpp
#
################################################################################


TEV_CPP_VERSION = v2.3
TEV_CPP_SITE = https://github.com/chemwolf6922/tiny-event-loop-cpp
TEV_CPP_SITE_METHOD = git
TEV_CPP_INSTALL_STAGING = YES
TEV_CPP_INSTALL_TARGET = NO

$(eval $(cmake-package))
