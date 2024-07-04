FROM tomcat:9-jre11
COPY target/hello-world.war /usr/local/tomcat/webapps/