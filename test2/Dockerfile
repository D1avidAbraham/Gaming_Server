ARG SUNSHINE_VERSION=latest
ARG SUNSHINE_OS=ubuntu-22.04
FROM lizardbyte/sunshine:${SUNSHINE_VERSION}-${SUNSHINE_OS}
 
 



# copies the starter file and make it executable
COPY start_services.sh /usr/local/bin/start_services.sh
RUN sudo chmod +x /usr/local/bin/start_services.sh

# runs the file
CMD ["/usr/local/bin/start_services.sh"]