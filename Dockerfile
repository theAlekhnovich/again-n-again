FROM alpine:latest
RUN apk add mutt msmtp ln -sf /usr/bin/msmtp /usr/sbin/sendmail
ADD msmtprc /etc/msmtprc
