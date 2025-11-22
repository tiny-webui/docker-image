EXTERNAL_PATH=external
TARGET_PLATFORM?=x64
EXTERNAL_CONFIG_NAME=tiny-webui-$(TARGET_PLATFORM)_defconfig
OUTPUT_DIR=output
IMAGE_OUTPUT_DIR=$(OUTPUT_DIR)/$(TARGET_PLATFORM)

all:docker-image

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
	rm -rf $(IMAGE_OUTPUT_DIR)
	mkdir -p $(IMAGE_OUTPUT_DIR)
	cp buildroot/output/images/rootfs.tar $(IMAGE_OUTPUT_DIR)/

.PHONY:docker-image
docker-image:
	$(MAKE) image
	$(MAKE) image TARGET_PLATFORM=arm64
	rm -rf $(OUTPUT_DIR)/amd64
	ln -sf x64 $(OUTPUT_DIR)/amd64
	docker buildx create || true
	docker buildx build \
		--platform linux/amd64,linux/arm64 \
		-f docker/Dockerfile \
		-t tiny-webui:latest \
		--output type=oci,dest=$(OUTPUT_DIR)/tiny-webui.tar \
		.

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
	rm -rf $(OUTPUT_DIR)
