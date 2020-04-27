ARG TERRAFORM_VERSION=0.12.23
ARG TERRAFORM_PROVIDER_VERSION=1.39.0

# For caching purposes
FROM alpine as providers

RUN ls -lrt /
RUN mkdir -p /usr/providers

# Add providers here
RUN wget -O terraform-${TERRAFORM_PROVIDER_VERSION}.zip https://releases.hashicorp.com/terraform-provider-azurerm/1.39.0/terraform-provider-azurerm_${TERRAFORM_PROVIDER_VERSION}_linux_amd64.zip && \
    unzip -d /usr/providers terraform-${TERRAFORM_PROVIDER_VERSION}.zip
RUN ls -lrt /usr/providers

# Add them to hashicorp/terraform image
FROM hashicorp/terraform:${TERRAFORM_VERSION}

COPY --from=providers /usr/providers/terraform-provider-azurerm_v${TERRAFORM_PROVIDER_VERSION}_x4 /bin/

