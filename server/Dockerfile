FROM alpine:3.20
# Update by changing PB_VERSION (check github.com/pocketbase/pocketbase/releases) and rebuilding.
ARG PB_VERSION=0.40.5
ARG TARGETARCH=amd64
RUN apk add --no-cache ca-certificates unzip
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_${TARGETARCH}.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/ && rm /tmp/pb.zip
EXPOSE 8090
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8090"]
