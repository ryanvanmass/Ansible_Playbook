FROM ubuntu:20.04 as build

# Install Hugo
RUN apt update
RUN apt install hugo -y 

# Create Directory for mounting to
RUN mkdir /Website

# Force the shell to default to /Website instead of /
RUN echo "cd /Website" >> /root/.bashrc

# Set up Alias's for Hugo
RUN echo "alias draft-server='hugo server -D --bind 0.0.0.0 -p 1313'" >> /root/.bashrc
RUN echo "alias prod-server='hugo server --bind 0.0.0.0 -p 1313'" >> /root/.bashrc
RUN echo "alias new-post='hugo new post'" >> /root/.bashrc
