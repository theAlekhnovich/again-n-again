FROM debian:bookworm-slim
RUN sudo apt install mutt msmtp ln -sf /usr/bin/msmtp /usr/sbin/sendmail
ADD msmtprc /etc/msmtprc
