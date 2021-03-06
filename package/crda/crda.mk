################################################################################
#
# crda
#
################################################################################

CRDA_VERSION = 1.1.3
CRDA_SOURCE = crda-$(CRDA_VERSION).tar.bz2
CRDA_SITE = http://wireless.kernel.org/download/crda
CRDA_DEPENDENCIES = host-pkgconf host-python-m2crypto \
	libnl libgcrypt
CRDA_LICENSE = ISC
CRDA_LICENSE_FILES = LICENSE

# libnl-3 needs -lm (for rint) and -lpthread if linking statically.
# And library order matters hence stick -lnl-3 first since it's appended
# in the crda Makefiles as in NLLIBS+=-lnl-3 ... thus failing.
#
# libgcrypt needs -lgpg-error if linking statically, which is correctly
# set by the libgcrypt-config script (and in the right order).
ifeq ($(BR2_PREFER_STATIC_LIB),y)
CRDA_NLLIBS += -lnl-3 -lm -lpthread
CRDA_LDLIBS += `$(STAGING_DIR)/usr/bin/libgcrypt-config --libs`
endif

define CRDA_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) \
		LDLIBS="$(CRDA_LDLIBS)" \
		NLLIBS="$(CRDA_NLLIBS)" \
		$(MAKE) all_noverify -C $(@D)
endef

define CRDA_INSTALL_TARGET_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) install -C $(@D) DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
