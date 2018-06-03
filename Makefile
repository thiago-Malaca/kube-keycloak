NAMESPACE ?= dev-keycloak
HELM_APPLICATION_NAME ?= keycloak
HELM_VALUES ?= ./values.yaml
CHART_LOCATION ?= .

# HOST=local.sso.taki.com.vc
# HOST-MANAGER=./tools/host-manager.sh

helm-install:
	helm dependency update $(CHART_LOCATION)
	helm upgrade -f $(HELM_VALUES) \
	             --install \
	             --namespace=$(NAMESPACE) \
	             --debug \
	             $(HELM_APPLICATION_NAME) \
	             $(CHART_LOCATION)
	# sudo $(HOST-MANAGER) -remove $(HOST)
	# sudo $(HOST-MANAGER) -add $(HOST) $$(minikube ip)
	# sudo $(HOST-MANAGER) -remove flower.$(HOST)
	# sudo $(HOST-MANAGER) -add flower.$(HOST) $$(minikube ip)

helm-check:
	helm install --dry_run \
	            $(CHART_LOCATION) \
	             --version=v0.1.0 \
	             --name=$(HELM_APPLICATION_NAME) \
	             --namespace=$(NAMESPACE) \
	             --debug \
	             -f $(HELM_VALUES)

helm-ls:
	helm ls --all $(HELM_APPLICATION_NAME)

helm-uninstall:
	helm del --purge $(HELM_APPLICATION_NAME)



# MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
# CURRENT_DIR := $(notdir $(patsubst %/,%,$(dir $(MKFILE_PATH))))
# PART ?= "patch"

# .PHONY: package
# package:
# 	@echo "Packaging Chart $(CURRENT_DIR)"
# 	helm package $(CURRENT_DIR)

# .PHONY: dependencies
# dependencies:
# 	@echo "Installing dependencies"
# 	helm dependency update

# .PHONY: bump
# bump:
# 	@echo "Bumping Version"
# 	bumpversion ${PART}
# 	git push
# 	git push origin --tags




