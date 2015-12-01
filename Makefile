ARCHS = armv7 armv7s arm64 
THEOS_DEVICE_IP=192.168.2.95

include theos/makefiles/common.mk

TWEAK_NAME = Leash
Leash_FILES = Tweak.xm
Leash_LDFLAGS += -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
