FROM ruby:2.7.3

# Install dependencies
RUN apt-get update && apt-get install -y build-essential zlib1g-dev ruby ruby-dev openssl libxslt1-dev libxml2-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3

# Install BOSH
RUN wget https://github.com/cloudfoundry/bosh-cli/releases/download/v7.6.2/bosh-cli-7.6.2-linux-amd64
RUN chmod +x bosh-cli-7.6.2-linux-amd64 && mv ./bosh-cli-7.6.2-linux-amd64 /usr/local/bin/bosh

RUN git clone https://github.com/cloudfoundry/bosh-package-ruby-release /bosh-package-ruby-release

WORKDIR /app

COPY . /app

RUN bosh vendor-package -n ruby-2.7 /bosh-package-ruby-release
