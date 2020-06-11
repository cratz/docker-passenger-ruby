FROM phusion/passenger-customizable:1.0.10

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

RUN mv /pd_build/ruby-2.6.6.sh /pd_build/ruby-2.6.1.sh
RUN /pd_build/ruby-2.6.*.sh
#   Node.js and Meteor standalone support.
#   (not needed if you already have the above Ruby support)
#RUN /pd_build/nodejs.sh

RUN rm /etc/nginx/sites-enabled/default
RUN mkdir /home/app/webapp

WORKDIR /home/app/webapp

RUN bash -lc 'rvm --default use ruby-2.6.1'
run gem install bundler:1.17.3

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
