# SPDX-FileCopyrightText: 2022 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

REGISTRY              := eu.gcr.io/gardener-project
PROJECT               := github.com/gardener/portmap-copier
IMAGE_REPOSITORY      := $(REGISTRY)/gardener/portmap-copier
REPO_ROOT             := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
VERSION               := $(shell cat VERSION)
IMAGE_TAG             := $(VERSION)
EFFECTIVE_VERSION     := $(VERSION)-$(shell git rev-parse HEAD)
GOARCH                := amd64

.PHONY: docker-images
docker-images:
	@docker build -t $(IMAGE_REPOSITORY):$(IMAGE_TAG) -f Dockerfile .

