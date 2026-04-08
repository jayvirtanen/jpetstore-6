#
#    Copyright 2010-2026 the original author or authors.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#       https://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#

# Runtime-only image for jpetstore-6
FROM tomcat:9.0-jdk17-temurin

# Clean default webapps so only jpetstore is deployed
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR produced by: mvn package
COPY target/jpetstore.war /usr/local/tomcat/webapps/jpetstore.war

EXPOSE 8080

# Optional but useful for Kubernetes / Docker health checks
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=5 \
  CMD curl -fsS http://localhost:8080/jpetstore/ || exit 1

CMD ["catalina.sh", "run"]
