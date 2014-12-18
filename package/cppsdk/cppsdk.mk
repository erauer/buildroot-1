################################################################################
#
# cppsdk
#
################################################################################
# CPPSDK_VERSION = 00a5981f771edc475aa5568f1cdd660d6aae2189
CPPSDK_VERSION = master
CPPSDK_SITE_METHOD = git
CPPSDK_SITE = git@github.com:Metrological/cppsdk.git
CPPSDK_INSTALL_STAGING = YES
ifeq ($(BR2_PACKAGE_CPPSDK_GENERICS),y)
  CPPSDK_GENERICS_BUILD = $(MAKE) CXX=$(TARGET_CXX) -C $(@D)/generics build
  CPPSDK_GENERICS_INSTALL_STAGING = $(MAKE) -C $(@D)/generics staging
  CPPSDK_GENERICS_INSTALL_TARGET = $(MAKE) -C $(@D)/generics target
endif
ifeq ($(BR2_PACKAGE_CPPSDK_WEBSOCKET),y)
  CPPSDK_WEBSOCKET_BUILD = $(MAKE) CXX=$(TARGET_CXX) -C $(@D)/websocket build
  CPPSDK_WEBSOCKET_INSTALL_STAGING = $(MAKE) -C $(@D)/websocket staging
  CPPSDK_WEBSOCKET_INSTALL_TARGET = $(MAKE) -C $(@D)/websocket target
endif
ifeq ($(BR2_PACKAGE_CPPSDK_TRACING),y)
  CPPSDK_TRACING_BUILD = $(MAKE) CXX=$(TARGET_CXX) -C $(@D)/tracing build
  CPPSDK_TRACING_INSTALL_STAGING = $(MAKE) -C $(@D)/tracing staging
  CPPSDK_TRACING_INSTALL_TARGET = $(MAKE) -C $(@D)/tracing target
endif
ifeq ($(BR2_PACKAGE_CPPSDK_DEVICES),y)
  CPPSDK_DEVICES_BUILD = $(MAKE) CXX=$(TARGET_CXX) -C $(@D)/devices build
  CPPSDK_DEVICES_INSTALL_STAGING = $(MAKE) -C $(@D)/devices staging
  CPPSDK_DEVICES_INSTALL_TARGET = $(MAKE) -C $(@D)/devices target
endif
define CPPSDK_BUILD_CMDS
  $(CPPSDK_GENERICS_BUILD)
  $(CPPSDK_WEBSOCKET_BUILD)
  $(CPPSDK_TRACING_BUILD)
  $(CPPSDK_DEVICES_BUILD)
endef
define CPPSDK_INSTALL_STAGING_CMDS
  $(CPPSDK_GENERICS_INSTALL_STAGING)
  $(CPPSDK_WEBSOCKET_INSTALL_STAGING)
  $(CPPSDK_TRACING_INSTALL_STAGING)
  $(CPPSDK_DEVICES_INSTALL_STAGING)
endef
define CPPSDK_INSTALL_TARGET_CMDS
  $(CPPSDK_GENERICS_INSTALL_TARGET)
  $(CPPSDK_WEBSOCKET_INSTALL_TARGET)
  $(CPPSDK_TRACING_INSTALL_TARGET)
  $(CPPSDK_DEVICES_INSTALL_TARGET)
endef

$(eval $(generic-package))
