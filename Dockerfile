# Pull base image 
FROM tomcat:8-jre8 

# Maintainer 
MAINTAINER "sam2500@me.com"

# Copy artifacet from the Jenkins target folder into the directory of the tomcat docker conatiner.
COPY ./target/*.war /usr/local/tomcat/webapps
