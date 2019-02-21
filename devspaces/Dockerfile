FROM thechangelog/runtime

LABEL \
    "com.trilogy.product"="changelog.com" \
    "com.trilogy.company"="External" \
    "com.trilogy.stage"="dev" \
    "com.trilogy.maintainer.skype"="otaviocx" \
    "com.trilogy.maintainer.email"="otaviocalaca.xavier@aurea.com" \
    "description"="This file generates a docker image containing all the deps and tools needed to build changelog.com project"

ENV MIX_ENV=devspaces

ADD scripts /opt

RUN chmod a+x /opt/*.sh && \
    apt-get update -y && \
    # Install postgresql
    apt-get install -y postgresql postgresql-contrib && \
    apt-get clean all

WORKDIR /data

ENTRYPOINT /opt/entrypoint.sh
