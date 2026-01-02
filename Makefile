EXTERNAL_PATH=external
TARGET_PLATFORM?=x64
EXTERNAL_CONFIG_NAME=tiny-webui-$(TARGET_PLATFORM)_defconfig
OUTPUT_DIR=output
IMAGE_OUTPUT_DIR=$(OUTPUT_DIR)/$(TARGET_PLATFORM)

REGISTRY_HOST?=127.0.0.1
REGISTRY_PORT?=5000
REGISTRY_NAME?=registry
REGISTRY_IMAGE?=registry:2
IMAGE_NAME?=tiny-webui
IMAGE_TAG?=latest
REGISTRY_REF=$(REGISTRY_HOST):$(REGISTRY_PORT)/$(IMAGE_NAME):$(IMAGE_TAG)

BUILDX_BUILDER?=tui-builder

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
	@if docker ps -a --format '{{.Names}}' | grep -qx '$(REGISTRY_NAME)'; then \
		docker inspect -f '{{.State.Running}}' '$(REGISTRY_NAME)' 2>/dev/null | grep -qx true || docker start '$(REGISTRY_NAME)' >/dev/null; \
	else \
		docker run -d -p '$(REGISTRY_PORT):5000' --name '$(REGISTRY_NAME)' '$(REGISTRY_IMAGE)' >/dev/null; \
	fi
	@docker buildx inspect '$(BUILDX_BUILDER)' >/dev/null 2>&1 || \
		docker buildx create --name '$(BUILDX_BUILDER)' --driver docker-container --driver-opt network=host --use >/dev/null
	@docker buildx use '$(BUILDX_BUILDER)' >/dev/null
	docker buildx build \
		--platform linux/amd64,linux/arm64 \
		-f docker/Dockerfile \
		-t $(REGISTRY_REF) \
		--push \
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
