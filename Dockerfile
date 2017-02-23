FROM container4armhf/armhf-alpine 
MAINTAINER ubiq <Segmentation-fault@yandex.ua>

COPY recfsusb2n_http_patch2.zip / 

RUN apk upgrade --update \
    && apk add --virtual .build \
                git \
                unzip \
                make \
                g++ \
    \
    && apk add \
                boost-dev \
                'nodejs>=6.2.0' \
                bash \
    \

# recfsusb2nのビルド
    && git clone https://github.com/sh0/recfsusb2n.git \
    && unzip -o recfsusb2n_http_patch2.zip -d /recfsusb2n/src/ \
    && cd /recfsusb2n/src \

    # ビルドできるように細工する
    && sed -i -e "s/u_char/unsigned char/g" tssplitter_lite.h \
    && sed -i -e "s/u_char/unsigned char/g" fsusb2n.cpp \
    && sed -i -e "84 s/stdout/stdout_/g" fsusb2n.cpp \
    && sed -i -e "s/args.stdout/args.stdout_/g" fsusb2n.cpp \
    && sed -i -e "s/-march=native//g" Makefile \ 
    && sed -i -e "15 s/#LIBS/LIBS/g" Makefile \
    && sed -i -e "16 s/LIBS/#LIBS/g" Makefile \

    && make -j4 \
    && cp ./recfsusb2n /usr/bin \

# mirakurunのインストール
    && npm install pm2 -g \
    && npm install mirakurun -g --unsafe --production \

# 余分なファイルを消す
    && apk del --purge .build \
    && rm -fr /tmp/* \
    && rm -fr /var/cache/apk/*

COPY services.sh /usr/local/bin

CMD ["/usr/local/bin/services.sh"]
EXPOSE 40772
