EXTERNAL_PATH=external
EXTERNAL_CONFIG_NAME=tiny-webui-x64_defconfig

all:image

.PHONY:config
config:
	$(MAKE) -C buildroot distclean
	$(MAKE) -C buildroot BR2_EXTERNAL=../$(EXTERNAL_PATH) $(EXTERNAL_CONFIG_NAME)

.PHONY:menuconfig
menuconfig:config
	$(MAKE) -C buildroot menuconfig

.PHONY:savedefconfig
savedefconfig:
	$(MAKE) -C buildroot savedefconfig

.PHONY:image
image:config
	mkdir -p dl_cache
	cp -r dl_cache buildroot/dl
	$(MAKE) -C buildroot 
	rm -rf output
	mkdir -p output
	cp buildroot/output/images/rootfs.tar output

.PHONY:dl_cache
dl_cache:config
	mkdir -p dl_cache
	cp -r dl_cache buildroot/dl
	$(MAKE) -C buildroot source
	rm -rf dl_cache
	cp -r buildroot/dl dl_cache

.PHONY:clean
clean:
	$(MAKE) -C buildroot distclean
	rm -rf output
