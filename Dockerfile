FROM maven AS buildstage
RUN mkdir /opt/mc
WORKDIR /opt/mc
COPY . .
RUN mvn clean install #this will generate .war in target directory 

#new stage 
FROM tomcat 
WORKDIR webapps
# Copying only .war artifact from target dir -old state to this stage  
COPY --from=buildstage /opt/mc/target/*.war .
RUN rm -rf ROOT && mv *.war ROOT.war
EXPOSE 8080
