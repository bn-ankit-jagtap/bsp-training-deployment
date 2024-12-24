FROM alpine/git
RUN apk update && apk add aws-cli
WORKDIR /aj 
COPY . .
RUN chmod +x dummy-pod.sh
ENTRYPOINT ["/bin/sh", "dummy-pod.sh"]